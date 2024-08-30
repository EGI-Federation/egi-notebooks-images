# 2024-07-02
# hub-5.0.0
# julia-1.10.4
# lab-4.2.3
# notebook-7.2.1
# python-3.11.9
# r-4.3.3
# ubuntu-22.04
FROM quay.io/jupyter/datascience-notebook:615b8cc01b33

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
    && conda clean --all

RUN pip install --no-cache-dir \
        shortid \
        nbgitpuller \
        git+https://github.com/EGI-Federation/notebooks-resource-warning

WORKDIR "${HOME}"

RUN NODE_OPTIONS="--openssl-legacy-provider" \
    jupyter labextension install \
        @jupyter-widgets/jupyterlab-manager jupyter-leaflet
