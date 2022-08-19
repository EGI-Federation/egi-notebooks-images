#   _____       ____  _       _____        _                    
#  / ____|     |  _ \(_)     |  __ \      | |         _     _   
# | (___   ___ | |_) |_  __ _| |  | | __ _| |_ __ _ _| |_ _| |_ 
#  \___ \ / _ \|  _ <| |/ _` | |  | |/ _` | __/ _` |_   _|_   _|
#  ____) | (_) | |_) | | (_| | |__| | (_| | || (_| | |_|   |_|  
# |_____/ \___/|____/|_|\__, |_____/ \__,_|\__\__,_|            
#                        __/ |                                  
#                       |___/      

ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

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
        scikit-mobility \
        dask-jobqueue \
        fs \
        rasterio \
        contextily \
        nb_conda_kernels \
        nb_conda \
    && conda clean -tipsy

# Pinned networkx to 2.6.3 as 2.7 makes networksns fail
RUN pip install --no-cache-dir \
        bicm \
        rdp \
        sentinelhub \
        import_ipynb \
        nbresuse \
        ndlib \
        motuclient \
        panel==0.9.* \
        cdlib[C]==0.2.3 \
        cython \
        node_conformity \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/guglielmocola/RetweetCascade.git@f96319d0107473715104acceb2ff0925d35dd9e3 \
        fast-forward-indexes \
        NEMtropy \
        folium==0.11.0 \
        geopy==2.0.0 \
        hvplot==0.6.0 \
        intake==0.6.0 \
        intake-esm==2020.8.15 \
        hda \
        seaborn==0.11.0 \
        zarr==2.5.0 \
        holoviews \
        networkx==2.6.3 \
        networksns \

# -------------------------------
# SoBigData ++ specific libraries
# -------------------------------
RUN mamba install -y --quiet \
        pyspark \
        pyfim \
        pyclustering \
        transformers \
        rtree \
        geopandas \
        nltk \
        pydotplus \
        plotly \
        graphviz \
        keras \
        selenium \
        tweepy \
        openjdk=8 \
   && conda clean --all

RUN  mamba install -y pytorch==1.6.0  torchtext torchvision -c pytorch \
   && conda clean --all

RUN pip install --no-cache-dir \
        import_ipynb \
        opencv-python \
        simpletransformers \
        shuffle-graph 
# -------------------------------

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
