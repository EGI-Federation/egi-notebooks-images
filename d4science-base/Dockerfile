# 7e1a19a8427f updates python and Julia
# Using that to ensure the image remains the same
FROM jupyter/datascience-notebook:7e1a19a8427f

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
        nbgitpuller \
    && conda clean --all

RUN pip install --no-cache-dir shortid

WORKDIR "${HOME}"

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
