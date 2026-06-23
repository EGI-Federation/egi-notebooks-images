# 2026-06-23
# hub-5.5.0
# julia-1.12.6
# lab-4.6.0
# notebook-7.6.0
# python-3.13.14
# r-4.5.3
# ubuntu-24.04.4
FROM quay.io/jupyter/datascience-notebook:91aceb0b50cd

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

RUN mamba install -y -q \
        r-plotly \
        r-gdata \
        rdflib \
        prov \
        graphviz \
        pydot \
        lxml \
        geojson \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
        jupyter-server-proxy \
        jupyterlab_widgets \
        nodejs \
    && conda clean --all

RUN pip install --no-cache-dir \
        shortid \
        nbgitpuller \
        git+https://github.com/EGI-Federation/notebooks-resource-warning

COPY --chown=$NB_UID:$NB_GID overrides.json /opt/conda/share/jupyter/lab/settings/
