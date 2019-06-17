FROM jupyter/datascience-notebook:d4cbf2f80a2a

USER root
RUN apt-get update \
    && apt-get install -y graphviz vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


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
        beakerx \
        xgboost \
        lightgbm \
        catboost \
    && conda update --all \
    && conda clean -tipsy

RUN conda create --quiet --yes -n java8 \
    && conda install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

RUN pip install shortid \
        nbgitpuller \
        rdp \
        sentinelhub \
        git+https://github.com/geopython/OWSLib.git

RUN jupyter labextension install jupyter-leaflet \
    && jupyter labextension disable @jupyterlab/hub-extension

# Allow sudo access ?
USER root
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

USER $NB_UID
RUN rmdir work
