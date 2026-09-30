# R 4.5.3
# published on 2026-09-26
FROM quay.io/jupyter/datascience-notebook@sha256:4f2234a0fe4e113e4639cd179ba18981ea2476e41f309a22855f1357c7743429

# Builds image as requested in https://support.d4science.org/issues/32070
RUN Rscript -e 'remotes::install_version("rfishbase", version = "3.1.10", repos = Sys.getenv("CRAN", unset = "https://cloud.r-project.org"), upgrade = "never")' && \
    Rscript -e 'stopifnot(packageVersion("rfishbase") == "3.1.10"); cat("rfishbase pinned to", as.character(packageVersion("rfishbase")), "\n")' && \
    rm -rf /tmp/downloaded_packages/*

# FLR packages.
#
# WARNING: the old mirror http://flr-project.org/R is no longer usable: the domain
# answers with a 301 redirect to an unrelated third-party site and no longer
# serves an R repository. The project's official repository is now r-universe.
#
# WARNING: the /bin/linux/... path on r-universe does NOT serve prebuilt binaries
# (no entry carries a Built: field), so FLR packages are COMPILED FROM SOURCE:
# FLCore, FLAssess, FLBRP, FLa4a and FLife contain C++ code, so this step takes
# several minutes and is the main OOM candidate on the build agent.
# Only the CRAN dependencies come as binaries, from P3M (third repo in the list).
#
# Only the package names are taken from r_non_cran_pkgs.txt, not the mirror listed
# in that file. FLEDA and diags are not on r-universe and come from GitHub below.
#
# spict (SPiCT, one of the methods required for the training) is appended to that
# list: it is not in r_non_cran_pkgs.txt, but r-universe publishes it alongside
# the FLR stack, so it comes from here instead of GitHub (its TMB model is still
# compiled from source).
ADD https://code-repo.d4science.org/gCubeSystem/r-packages-list/raw/branch/master/r_non_cran_pkgs.txt /tmp
# NOTE: do NOT use --no-site-file here. The rocker image's Rprofile.site sets both
# options(repos) and options(HTTPUserAgent): without the latter P3M serves sources
# instead of binaries, and without the former install.packages fails with
# "trying to use CRAN without setting a mirror". The CRAN repo is taken from the
# CRAN environment variable, which the base image sets.
RUN FLR_BIN="https://flr.r-universe.dev/bin/linux/noble-x86_64/${R_MINOR}" ; \
    FLR_SRC="https://flr.r-universe.dev" ; \
    PKGS="`cut -d : -f 1 /tmp/r_non_cran_pkgs.txt` spict" ; \
    for pkg in $PKGS ; do \
    case "$pkg" in FLEDA|diags|'') continue ;; esac ; \
    Rscript --no-init-file --no-save --no-restore-history \
    -e "repos <- c('$FLR_BIN', '$FLR_SRC', Sys.getenv('CRAN', unset='https://cloud.r-project.org'))" \
    -e "install.packages(pkgs='$pkg', repos=repos)" \
    -e "if (!requireNamespace('$pkg', quietly=TRUE)) { message('FAILED to install $pkg'); quit(status=1) }" \
    || exit 1 ; done && \
    rm -f /tmp/r_non_cran_pkgs.txt && \
    rm -rf /tmp/downloaded_packages/*

# spict: silence the spurious checkTMBversion() warning.
#
# spict ships inst/TMB-version inside its tarball, holding the TMB version of the
# machine that packaged it (currently TMB_v1.9.19). checkTMBversion() compares
# that file with the installed TMB and, when they differ, every library(spict)
# prints
#   "Package version inconsistency detected ... Please re-install 'spict' from source"
# Here spict IS already compiled from source against the image's TMB (1.9.21), so
# there is no ABI mismatch: the warning is purely cosmetic, but for a training
# with many users it is noise that generates support requests.
# checkTMBversion() rewrites the file when it is missing, so we delete it and let
# spict regenerate it: that way we do not depend on the exact string format.
RUN set -e ; \
    P=$(Rscript -e 'cat(find.package("spict"))') ; \
    rm -f "$P/TMB-version" ; \
    Rscript -e 'suppressPackageStartupMessages(library(spict)); spict:::checkTMBversion()' ; \
    if Rscript -e 'library(spict)' 2>&1 | grep -qi 'inconsistency' ; then \
      echo "spict: checkTMBversion warning is still present" ; exit 1 ; \
    fi ; \
    echo "spict: aligned with the image's TMB ($(cat "$P/TMB-version"))"

# GitHub packages.
#
# GITHUB_PAT is optional and only raises the GitHub API rate limit (60 requests
# per hour per IP when unauthenticated, shared across every job running on the
# same agent). It is NO LONGER written to Renviron.site, where it used to stay in
# clear text inside the image: it is passed to this RUN only.
# With the classic builder (docker.io 20.10 on the Jenkins agent) the value is
# still visible in "docker history": use a read-only, short-lived token.
ARG GITHUB_PAT=""

# MAKEFLAGS caps g++ parallelism: sraplus, FishLife and lbmsmt compile TMB/Stan
# models and a single translation unit can need several GB of RAM.
ENV MAKEFLAGS="-j2"

# P3M binary repository used by remotes to resolve dependencies.
# This used to point at __linux__/focal/latest: focal is EOL since April 2025, has
# no binaries for R 4.5, and packagemanager.rstudio.com is the legacy domain.
ARG PPM_REPO="https://packagemanager.posit.co/all/__linux__/noble/latest"

# Packages already present in the 4.2 version of the image.
# james-thorson/FishLife was renamed to James-Thorson-NOAA/FishLife.
RUN installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} DanOvando/sraplus && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} sofia-tsaf/SOFIA && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} jabbamodel/JABBA && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} tokami/lbmsmt && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} James-Thorson-NOAA/FishLife && \
    rm -rf /tmp/downloaded_packages/*

# FLEDA and diags: part of the FLR stack but not published on r-universe.
RUN installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} flr/FLEDA && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} flr/diags && \
    rm -rf /tmp/downloaded_packages/*

# SOFIA-TAF methods required for the training (FLicc, SPiCT, JABBA, JARA).
# JABBA is installed above; spict comes from r-universe together with the FLR
# stack, so only JARA and FLicc are left here.
# FLicc depends on FLCore and ggplotFL, so it must come after the r-universe step.
RUN installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} henning-winker/JARA && \
    installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} henning-winker/FLicc && \
    rm -rf /tmp/downloaded_packages/*

# SPMpriors derives Pella-Tomlinson priors from FishLife; needed by the training
# vignette. FishLife itself is already installed above (the requested
# james-thorson/FishLife is the old name, 301-redirecting to the NOAA repo).
RUN installGithub.r -d TRUE -u FALSE -r ${PPM_REPO} henning-winker/SPMpriors && \
    rm -rf /tmp/downloaded_packages/*
