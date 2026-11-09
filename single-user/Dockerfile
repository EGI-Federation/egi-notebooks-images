# 2026-10-26
# hub-6.1.1
# julia-1.13.2
# lab-4.6.4
# notebook-7.6.3
# python-3.13.17
# r-4.5.3
# ubuntu-26.04
FROM quay.io/jupyter/datascience-notebook:4aa9f4159aaf AS base

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID

COPY base.yml /tmp/base.yml

RUN mamba install -y -f /tmp/base.yml \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

COPY --chown=$NB_UID:$NB_GID overrides.json /opt/conda/share/jupyter/lab/settings/

# adds system-wide setting for rstudio to use wget instead libcurl
RUN echo 'options(download.file.method = "wget")' >> /opt/conda/lib/R/etc/Rprofile.site

#
# Octave and RStudio additions
#
FROM base AS full-base

RUN apt-get update \
    # Octave
    && apt-get install --install-recommends -y \
        octave octave-signal gnuplot \
    # RStudio
    && apt-get install -y gdebi-core \
    && wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2026.10.1-239-amd64.deb \
    && gdebi -n rstudio-server-2026.10.1-239-amd64.deb \
    && rm rstudio-server-2026.10.1-239-amd64.deb \
    && apt-get remove -y gdebi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY full-base.yml /tmp/full-base.yml

RUN mamba install -y -f /tmp/full-base.yml \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

#
# SINGLE USER EGI
#
FROM full-base AS single-user

COPY single-user.yml /tmp/single-user.yml

RUN mamba install -y -f /tmp/single-user.yml \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"


#
# SINGLE USER EOSC
#
FROM full-base AS single-user-eosc

COPY single-user-eosc.yml /tmp/single-user-eosc.yml

RUN mamba install -y -f /tmp/single-user-eosc.yml \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# EOSC customisation
# TODO: trigger image build on changes to these files
COPY eosc /opt/conda/share/eosc
RUN set -x \
    && export PKG_PATH="$(python -c 'import jupyter_server; print(jupyter_server.__path__[0])')" \
    && mkdir -p "$PKG_PATH/static/custom/logo" \
    && ln -s /opt/conda/share/eosc/custom.css "$PKG_PATH/static/custom/" \
    && ln -s /opt/conda/share/eosc/eosc-ntb-logo.svg "$PKG_PATH/static/custom/logo" \
    && mkdir -p /opt/conda/share/jupyter/lab/settings/ \
    && ln -sf /opt/conda/share/eosc/overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json

RUN jupyter lab build

RUN rmdir work

# brew
USER root
RUN useradd -m -s /bin/bash linuxbrew
USER linuxbrew
RUN /bin/bash -c "HOME=/home/linuxbrew $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
USER root
RUN chmod 777 /home/linuxbrew && chown -R "$NB_UID" /home/linuxbrew/.linuxbrew

USER $NB_UID
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Turn off brew analytics
RUN brew analytics off
