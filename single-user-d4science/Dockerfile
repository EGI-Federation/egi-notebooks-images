FROM eginotebooks/base

RUN mamba install -y --quiet \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
    && conda clean -tipsy

RUN conda create --quiet --yes -n java8 \
    && mamba install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

RUN pip install shortid \
        nbgitpuller \
        rdp \
        sentinelhub \
        git+https://github.com/geopython/OWSLib.git

RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
