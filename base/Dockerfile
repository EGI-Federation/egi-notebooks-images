# 2026-05-04
# hub-5.4.5
# julia-1.12.6
# lab-4.5.7
# notebook-7.5.6
# python-3.13.13
# r-4.5.3
# ubuntu-24.04.4
FROM quay.io/jupyter/datascience-notebook:bc0e14e1b5a4

#FIXME: remove this line when datascience-notebook
#       with jupyterhub==5.4.6 is available 
RUN pip install --no-cache-dir jupyterhub==5.4.6

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
