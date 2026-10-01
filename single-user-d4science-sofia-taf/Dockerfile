# R 4.5.3
# published on 2026-09-26
FROM quay.io/jupyter/datascience-notebook@sha256:4f2234a0fe4e113e4639cd179ba18981ea2476e41f309a22855f1357c7743429

# Builds image as requested in https://support.d4science.org/issues/32070
#
# This image mirrors the R stack of the SOFIA-TAF RStudio image
# (harbor.d4science.org/rstudio/rstudio-d4science) so that the same analyses run
# in the JupyterHub R kernel and in RStudio.
#
# IMPORTANT - this base is NOT rocker. The RStudio chain is built on
# rocker/r-ver, and several of its assumptions do not hold here:
#
#   * R comes from conda-forge, lives in /opt/conda/lib/R and is compiled with
#     the conda toolchain (x86_64-conda-linux-gnu-c++), not the system g++.
#   * The base OS is Ubuntu 26.04, not 24.04 "noble".
#   * There is no CRAN environment variable and no rocker Rprofile.site: the
#     stock one only sets jupyter.plot_mimetypes, so getOption("repos") is the
#     unresolved placeholder "@CRAN@".
#   * littler is not installed, so install2.r and installGithub.r do not exist.
#
# Consequences for this Dockerfile:
#   * a CRAN mirror must be configured explicitly (see below);
#   * every package is installed with install.packages()/remotes, never with
#     install2.r or installGithub.r;
#   * P3M binary repositories are NOT used. P3M publishes binaries per Ubuntu
#     release built against the system R; they match neither Ubuntu 26.04 nor
#     this conda R, so everything here is compiled from source.
#
# Build time is therefore dominated by compilation. MAKEFLAGS below caps it.

# ---------------------------------------------------------------------------
# System dependencies
# ---------------------------------------------------------------------------

# cmake and pkg-config are required by several source builds in the dependency
# tree (nloptr, pulled in through arm/lme4, needs cmake) and are not in the base.
USER root
RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y \
        cmake \
        pkg-config \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_UID}

# JAGS, rjags and R2jags, needed by JABBA and JARA.
#
# These come from conda-forge rather than from CRAN, and the reason is worth
# recording because two more obvious routes do not work on this image:
#
#   * `mamba install jags` alone installs JAGS 5.0.0, the only version
#     conda-forge publishes standalone, and the CRAN rjags refuses it:
#       configure: error: rjags requires JAGS version 4.x.y
#   * the Ubuntu 26.04 package is JAGS 4.3.2, the right version, but building the
#     CRAN rjags against it fails with
#       configure: error: Runtime link error: See the INSTALL file for help
#     because this R comes from conda and does not link cleanly against the
#     system libraries.
#
# Installing r-rjags from conda-forge lets the solver pair the packages itself:
# it pulls JAGS 4.3.2 (not 5.0.0) as a dependency, built in the same prefix as R.
# Verified: R stays at 4.5.3, and library(rjags) loads.
#
# This must run BEFORE the GitHub installs, so that remotes finds rjags already
# present and upgrade = "never" leaves it alone instead of trying CRAN.
RUN mamba install --quiet --yes -c conda-forge r-rjags r-r2jags \
    && mamba clean --all -f -y \
    && Rscript -e 'stopifnot(getRversion() >= "4.5.3"); suppressPackageStartupMessages(library(rjags)); cat("rjags", as.character(packageVersion("rjags")), "on R", as.character(getRversion()), "\n")'

# ---------------------------------------------------------------------------
# CRAN mirror
# ---------------------------------------------------------------------------
#
# Without this every install.packages() fails with
#   Error in contrib.url(repos, type) :
#     trying to use CRAN without setting a mirror
# because the stock Rprofile.site leaves repos at "@CRAN@". Appending to
# Rprofile.site (rather than passing repos= on every call) also means the mirror
# is set for the users of the image, in notebooks and in the R console alike.
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"), download.file.method = "libcurl")' \
      >> "$(R RHOME)/etc/Rprofile.site" \
    && mirror=$(Rscript -e 'cat(getOption("repos")[["CRAN"]])') \
    && case "$mirror" in \
         @CRAN@|"") echo "CRAN mirror not set: '$mirror'" ; exit 1 ;; \
         *) echo "CRAN mirror: $mirror" ;; \
       esac

# Caps g++ parallelism: spict, FLicc, sraplus, stockassessment and lbmsmt compile
# TMB and Stan models, and a single translation unit can need several GB of RAM.
ENV MAKEFLAGS="-j2"

# remotes drives every GitHub install below. It is not in the base image, and
# devtools 2.5.x no longer pulls it in (it switched to pak), so it is explicit.
RUN Rscript -e 'install.packages("remotes")' \
    && Rscript -e 'stopifnot(requireNamespace("remotes", quietly = TRUE)); cat("remotes", as.character(packageVersion("remotes")), "\n")'

# ---------------------------------------------------------------------------
# TMB, PINNED to 1.9.21
# ---------------------------------------------------------------------------
#
# This pin is required, and it is required for one specific package.
#
# CRAN currently serves TMB 1.9.25, whose headers fail to compile in any
# translation unit that instantiates the GMRF path of tmbutils/density.hpp:
#   density.hpp:904: error: 'invertSparseMatrix' was not declared in this scope
#   spmat.hpp:140: note: ... declared here, later in the translation unit
# an upstream two-phase-lookup regression.
#
# Verified on THIS image (conda g++ 16.2.0), not assumed from the RStudio build:
#   TMB 1.9.25 -> spict compiles, stockassessment FAILS (and FLSAM with it,
#                 since FLSAM depends on it)
#   TMB 1.9.21 -> both compile
# The same failure was observed on Ubuntu 24.04 with g++ 13, so this is a TMB
# regression rather than a toolchain or distribution problem.
#
# TMB must be installed BEFORE anything that LinkingTo it, so that spict, FLicc,
# FLSAM, stockassessment, FLSRTMB and sraplus are all compiled against the same
# version. Remove the pin once TMB fixes this upstream.
RUN Rscript -e 'remotes::install_version("TMB", version = "1.9.21", upgrade = "never")' \
    && Rscript -e 'stopifnot(packageVersion("TMB") == "1.9.21"); cat("TMB pinned to", as.character(packageVersion("TMB")), "\n")'

# ---------------------------------------------------------------------------
# rfishbase, PINNED to 3.1.10
# ---------------------------------------------------------------------------
#
# FishLife (and SPMpriors, which builds on it) calls rfishbase::fishbase, a
# lazy-loaded taxonomy dataset dropped in rfishbase 4.0.0. With a current
# rfishbase every call fails with
#   'fishbase' is not an exported object from 'namespace:rfishbase'
# so FishLife::Search_species and SPMpriors::flmvn_traits are unusable.
# Verified: 5.0.3 -> KO, 3.1.10 -> OK for both.
#
# Upstream has not fixed this: FishLife main (3.1.0) and dev (3.2.0) both still
# reference rfishbase::fishbase.
#
# It is installed here, before the GitHub packages, so that those - which all run
# with upgrade = "never" - leave it alone.
# Trade-off: user code written against the rfishbase 4.x/5.x API will not work.
RUN Rscript -e 'remotes::install_version("rfishbase", version = "3.1.10", upgrade = "never")' \
    && Rscript -e 'stopifnot(packageVersion("rfishbase") == "3.1.10"); cat("rfishbase pinned to", as.character(packageVersion("rfishbase")), "\n")' \
    && rm -rf /tmp/downloaded_packages/*

# ---------------------------------------------------------------------------
# FLR stack, SPiCT, FLRef and msemodules, from the FLR r-universe repository
# ---------------------------------------------------------------------------
#
# The package NAMES come from r_non_cran_pkgs.txt, the shared D4Science list; the
# mirror listed inside that file is IGNORED. http://flr-project.org/R is no
# longer usable: the domain answers with a 301 redirect to an unrelated
# third-party site and no longer serves an R repository.
#
# spict, FLRef and msemodules are not in that list and are appended here.
# FLEDA and diags are in the list but are not published on r-universe: they are
# skipped here and installed from GitHub below.
#
# Note that r-universe's /bin/linux/... path does NOT serve prebuilt binaries
# (no entry carries a Built: field), so there is nothing to gain by pointing at
# it: the source repository is used directly.
#
# install.packages() only warns when a package fails to install, so Rscript would
# still exit 0 and "|| exit 1" would never fire: the explicit requireNamespace
# check is what makes a failure visible.
ADD --chown=${NB_UID}:${NB_GID} https://code-repo.d4science.org/gCubeSystem/r-packages-list/raw/branch/master/r_non_cran_pkgs.txt /tmp/r_non_cran_pkgs.txt
RUN FLR_SRC="https://flr.r-universe.dev" ; \
    PKGS="`cut -d : -f 1 /tmp/r_non_cran_pkgs.txt` spict FLRef msemodules" ; \
    for pkg in $PKGS ; do \
      case "$pkg" in FLEDA|diags|'') continue ;; esac ; \
      Rscript -e "install.packages(pkgs='$pkg', repos=c('$FLR_SRC', getOption('repos')))" \
              -e "if (!requireNamespace('$pkg', quietly=TRUE)) { message('FAILED to install $pkg'); quit(status=1) }" \
        || exit 1 ; \
    done && \
    rm -f /tmp/r_non_cran_pkgs.txt && \
    rm -rf /tmp/downloaded_packages/*

# spict: silence the spurious checkTMBversion() warning.
#
# spict ships inst/TMB-version inside its tarball, holding the TMB version of the
# machine that packaged it. checkTMBversion() compares it with the installed TMB
# and, when they differ, every library(spict) prints
#   "Package version inconsistency detected ... Please re-install 'spict' from source"
# Here spict IS compiled from source against this image's TMB, so there is no ABI
# mismatch: the warning is cosmetic, but for a training with many users it is
# noise that generates support requests. checkTMBversion() rewrites the file when
# it is missing, so we delete it and let spict regenerate it instead of depending
# on the exact string format.
RUN set -e ; \
    P=$(Rscript -e 'cat(find.package("spict"))') ; \
    rm -f "$P/TMB-version" ; \
    Rscript -e 'suppressPackageStartupMessages(library(spict)); spict:::checkTMBversion()' ; \
    if Rscript -e 'library(spict)' 2>&1 | grep -qi 'inconsistency' ; then \
      echo "spict: checkTMBversion warning is still present" ; exit 1 ; \
    fi ; \
    echo "spict: aligned with the image's TMB ($(cat "$P/TMB-version"))"

# ---------------------------------------------------------------------------
# GitHub packages
# ---------------------------------------------------------------------------
#
# GITHUB_PAT is optional and only raises the GitHub API rate limit (60 requests
# per hour per IP when unauthenticated, shared by every job on the same runner).
# remotes reads it from the environment, and build args are visible to RUN, so it
# does not need to be written anywhere: use a read-only, short-lived token.
ARG GITHUB_PAT=""

# These used to be installed with installGithub.r, which does not exist here
# (littler is a rocker component). remotes::install_github is the equivalent;
# upgrade = "never" is what keeps the TMB and rfishbase pins above intact.
#
# dependencies = TRUE reproduces installGithub.r's -d TRUE, which also installs
# Suggests. This is not cosmetic: comparing this image against the RStudio one
# package by package showed five missing without it, all reached through Suggests
# chains - archetypes (suggested by FishLife) and its dependency nnls,
# fitdistrplus (suggested by JARA), GGally (suggested by diags and FLife) and its
# dependency ggstats. The default of remotes::install_github installs only
# Depends/Imports/LinkingTo, which is NOT equivalent.

# FLEDA and diags: part of the FLR stack but not published on r-universe.
RUN Rscript -e 'remotes::install_github(c("flr/FLEDA", "flr/diags"), dependencies = TRUE, upgrade = "never")' \
    && rm -rf /tmp/downloaded_packages/*

# FAO/D4Science tooling. SOFIA pulls in TAF, the assessment framework the VRE is
# named after. sraplus and lbmsmt compile TMB and Stan models.
RUN Rscript -e 'remotes::install_github(c("DanOvando/sraplus", "sofia-tsaf/SOFIA", "tokami/lbmsmt"), dependencies = TRUE, upgrade = "never")' \
    && rm -rf /tmp/downloaded_packages/*

# JABBA and JARA are JAGS-based; rjags and R2jags come in as dependencies and
# need the JAGS installed above.
RUN Rscript -e 'remotes::install_github(c("jabbamodel/JABBA", "henning-winker/JARA"), dependencies = TRUE, upgrade = "never")' \
    && rm -rf /tmp/downloaded_packages/*

# FLicc is TMB-based and depends on FLCore and ggplotFL, installed above.
RUN Rscript -e 'remotes::install_github("henning-winker/FLicc", dependencies = TRUE, upgrade = "never")' \
    && rm -rf /tmp/downloaded_packages/*

# FishLife, then SPMpriors which derives Pella-Tomlinson priors from it.
# The originally requested james-thorson/FishLife is the old name and
# 301-redirects to the NOAA repository.
RUN Rscript -e 'remotes::install_github(c("James-Thorson-NOAA/FishLife", "henning-winker/SPMpriors"), dependencies = TRUE, upgrade = "never")' \
    && rm -rf /tmp/downloaded_packages/*

# ---------------------------------------------------------------------------
# Verification
# ---------------------------------------------------------------------------
#
# The full stack must be loadable. requireNamespace actually loads the namespace,
# so this also exercises lazy loading, where a missing shared library or a broken
# LinkingTo would surface.
#
# The list is not hand-written: it is the set of packages that the SOFIA-TAF
# customization adds on top of the platform, obtained by diffing the installed
# packages of r-full:4.5.3 against rstudio-d4science. The last five are the
# Suggests-reached ones that dependencies = TRUE brings in; they are listed
# explicitly so that losing them fails the build rather than drifting silently.
RUN Rscript -e ' \
    pkgs <- c("FLCore","ggplotFL","FLAssess","FLBRP","FLFishery","FLFleet","FLSAM","FLXSA","FLa4a","FLash","FLife", \
              "FLEDA","diags","stockassessment","spict","FLRef","msemodules","FLasher","FLSRTMB","mse", \
              "FLicc","JABBA","JARA","FishLife","SPMpriors","sraplus","SOFIA","lbmsmt", \
              "TAF","TMB","rjags","R2jags", \
              "archetypes","nnls","fitdistrplus","GGally","ggstats"); \
    ko <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]; \
    if (length(ko)) { message("Packages that cannot be loaded: ", paste(ko, collapse = ", ")); quit(status = 1) }; \
    message("SOFIA-TAF stack OK (", length(pkgs), " packages)")'

# Functional check for the FishLife/SPMpriors chain. Loading them is not enough:
# with a too recent rfishbase they load fine and then fail on the first call,
# which is exactly how the rfishbase problem was found.
RUN Rscript -e ' \
    suppressPackageStartupMessages({library(FishLife); library(SPMpriors)}); \
    invisible(capture.output(s <- FishLife::Search_species(Genus = "Thunnus", Species = "albacares"))); \
    invisible(capture.output(p <- SPMpriors::flmvn_traits(Genus = "Thunnus", Species = "albacares", Plot = FALSE))); \
    message("FishLife/SPMpriors functional check OK (rfishbase ", packageVersion("rfishbase"), ")")'

# The R kernel must see the stack too: the notebook runs through IRkernel, not
# through the Rscript used above.
RUN Rscript -e ' \
    stopifnot(requireNamespace("IRkernel", quietly = TRUE)); \
    libs <- .libPaths(); \
    stopifnot(any(file.exists(file.path(libs, "FLCore")))); \
    message("IRkernel sees the stack in: ", paste(libs, collapse = ", "))'
