# 59c973d16bca has python3.8.8
# Using that to ensure the image remains the same 
FROM jupyter/datascience-notebook:59c973d16bca

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
        jupyterlab==3.1.4 \
        notebook==6.4.1 \
        nbclassic==0.2.8 \
    && conda clean --all

RUN pip install --no-cache-dir \
        shortid \
        nbgitpuller

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
