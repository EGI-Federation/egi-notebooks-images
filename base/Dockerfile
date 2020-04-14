FROM jupyter/datascience-notebook:hub-1.1.0

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
        'r-plotly=4.9.2.1' \
        'r-gdata=2.18.0' \
        'rdflib=4.2.2' \
        'prov=1.5.3' \
        'graphviz=2.42.3' \
        'pydot=1.4.1' \
        'lxml=4.5.0' \
        'geojson=2.5.0' \
        'proj4=6.1.1' \
        'pydap=3.2.2' \
        'xarray=0.15.1' \
        'cartopy=0.17.0' \
        'ipyleaflet=0.12.3' \
    && conda clean -tipsy

RUN pip install shortid \
                nbgitpuller \
                git+https://github.com/enolfc/egi-hub-addons

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
