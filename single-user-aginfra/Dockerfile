FROM eginotebooks/base

RUN conda install -y --quiet \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

RUN conda create --quiet --yes -n java8 \
    && conda install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

RUN pip install shortid \
        nbgitpuller \
        rdp \
        sentinelhub \
        git+https://github.com/geopython/OWSLib.git

RUN jupyter labextension disable @jupyterlab/hub-extension \
    && jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
