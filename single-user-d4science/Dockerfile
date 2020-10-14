FROM eginotebooks/base

RUN mamba install -y --quiet \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
        netcdf4 \
        aiohttp \
    && conda clean -tipsy

RUN conda create --quiet --yes -n java8 \
    && mamba install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

RUN pip install shortid \
        nbgitpuller \
        rdp \
        sentinelhub \
        import_ipynb \
        git+https://github.com/obidam/pyxpcm.git \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/euroargodev/argopy.git@master

RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
