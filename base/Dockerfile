FROM jupyter/datascience-notebook:d4cbf2f80a2a

USER root

RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

RUN apt-get update \
    && apt-get install -y \
        graphviz \
        vim \
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
        xarray \
        cartopy \
        ipyleaflet \
        ipywidgets \
    && conda update --all \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# packages not in conda?
# TODO(enolfc): move the egi-hub-addons to a better place
RUN pip install shortid \
                nbgitpuller \
                git+https://github.com/enolfc/egi-hub-addons

RUN jupyter labextension install jupyter-leaflet
