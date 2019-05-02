FROM jupyter/datascience-notebook:a330137134e7

USER root
RUN apt-get update \
    && apt-get install -y \
        graphviz \
        vim \
        nodejs \
        octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID
RUN conda install -y --quiet \
        r-plotly \
        r-gdata \
        rdflib \
        prov \
        graphviz \
        pydot \
        xlrd \
        lxml \
        geojson \
        proj4 \
        pydap==3.2.1 \
        cftime \
        xarray \
        cartopy \
        ipyleaflet \
        ipywidgets \
        ipympl \
        jmespath \
        octave_kernel \
        simplegeneric \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# packages not in conda?
RUN pip install shortid \
                nbgitpuller

RUN jupyter labextension install jupyter-leaflet

USER root

# Allow sudo access
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

USER $NB_UID
RUN rmdir work
