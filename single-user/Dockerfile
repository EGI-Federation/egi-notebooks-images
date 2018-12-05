FROM jupyter/datascience-notebook:03b897d05f16

USER root
RUN apt-get update && \
    apt-get install -y graphviz vim nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID
RUN conda install -y r-plotly \
        r-gdata \
        rdflib \
        prov \
        graphviz \
        pydot \
        xlrd \
        lxml \
        geojson \
        proj4 \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
        ipywidgets \
        ipympl \
        jmespath

RUN pip install shortid \
        nbgitpuller

## Overwrite cartopy with branch to fix matplotlib 3.0 compat
#RUN pip install git+https://github.com/QuLogic/cartopy.git@mpl3

RUN jupyter labextension install jupyter-leaflet

# Allow sudo access ?
USER root
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

USER $NB_UID
RUN rmdir work
