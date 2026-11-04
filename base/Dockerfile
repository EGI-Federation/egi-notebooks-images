# 2026-10-26
# hub-6.1.1
# julia-1.13.2
# lab-4.6.4
# notebook-7.6.3
# python-3.13.17
# r-4.5.3
# ubuntu-26.04
FROM quay.io/jupyter/datascience-notebook:4aa9f4159aaf

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
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
