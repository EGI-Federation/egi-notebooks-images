# 6d42503c684f has python3.8 needed for samesite setting of cookies
# Using that to ensure the image remains the same
FROM jupyter/datascience-notebook:latest as base

# First state deals with the non-conda related stuff
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

RUN rmdir work

# Second stage deal with the conda specifics
FROM base

# install mamba which goes way faster than conda
RUN conda install mamba -y --quiet -c conda-forge \
    && mamba install -y -q \
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
    && conda clean --all

RUN pip install --no-cache-dir \
        shortid \
        nbgitpuller

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
