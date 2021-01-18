FROM eginotebooks/base

RUN mamba install -y --quiet \
        basemap \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
        netcdf4 \
        aiohttp \
        graph-tool \
        scikit-learn==0.22.1 \
    && conda clean -tipsy

RUN conda create --quiet --yes -n java8 \
    && mamba install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

RUN pip install shortid \
        bicm \
        nbgitpuller \
        rdp \
        oceans \
        sentinelhub \
        import_ipynb \
        nbresuse \
	ndlib \
	motuclient \
        shuffle-graph==1.1.2 \
        cdlib[C] \
        git+https://github.com/obidam/pyxpcm.git \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/euroargodev/argopy.git@master

RUN julia -e "using Pkg; Pkg.pin(\"IJulia\"); pkg\"add https://github.com/gher-ulg/DIVAndNN.jl\"; pkg\"add JSON PyCall PyPlot DIVAnd Glob DataStructures NCDataset\""

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
