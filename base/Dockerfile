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

# Fixing versions to try to speed up conda
USER $NB_UID

COPY env.yml /tmp/env.yml

RUN conda install -y pycryptosat \
    && conda config --set sat_solver pycryptosat \
    && conda env update -f /tmp/env.yml --prune \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

RUN jupyter labextension install --debug @jupyter-widgets/jupyterlab-manager jupyter-leaflet
