FROM jupyter/datascience-notebook:14fdfbf9cfc1

USER root
RUN apt-get update && \
    apt-get install -y graphviz vim nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
    pydap \
    xarray \
    cartopy \
    ipyleaflet \
    ipywidgets \
    ipympl \
    jmespath && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# packages not in conda?
RUN pip install shortid \
        nbgitpuller

RUN jupyter labextension install jupyter-leaflet

# Python 2 support

RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 ipython ipykernel kernda && \
    conda clean -tipsy

USER root

# Create a global kernelspec in the image and modify it so that it properly activates
# the python2 conda environment.
RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    $CONDA_DIR/envs/python2/bin/kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json

# Allow sudo access
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

USER $NB_UID
RUN rmdir work
