# 04f7f60d34a6 is hub-1.1.0 on 2020-06-24
# Using that to ensure the image remains the same
FROM jupyter/datascience-notebook:04f7f60d34a6

USER root

RUN apt-get update \
    && apt-get install -y \
        graphviz \
        vim \
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
        proj4 \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
    && conda clean --all

RUN pip install shortid \
                nbgitpuller \
                git+https://github.com/enolfc/egi-hub-addons

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
