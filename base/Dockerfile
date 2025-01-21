# 2024-12-10
# hub-5.2.1
# julia-1.11.1
# lab-4.3.2
# notebook-7.3.1
# python-3.12.3
# r-4.3.3
# ubuntu-22.04
FROM quay.io/jupyter/datascience-notebook:87b37b4fd818

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
