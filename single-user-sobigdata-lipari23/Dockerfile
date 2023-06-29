#   _____       ____  _       _____        _                    
#  / ____|     |  _ \(_)     |  __ \      | |         _     _   
# | (___   ___ | |_) |_  __ _| |  | | __ _| |_ __ _ _| |_ _| |_ 
#  \___ \ / _ \|  _ <| |/ _` | |  | |/ _` | __/ _` |_   _|_   _|
#  ____) | (_) | |_) | | (_| | |__| | (_| | || (_| | |_|   |_|  
# |_____/ \___/|____/|_|\__, |_____/ \__,_|\__\__,_|            
#                        __/ |                                  
#                       |___/      

ARG BASE_IMAGE=eginotebooks/d4science-base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
        g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

ARG SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

RUN mamba install -y --quiet \
        basemap \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
        netcdf4 \
        aiohttp \
        graph-tool \
        scikit-learn \
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
        cython \
        node_conformity \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/guglielmocola/RetweetCascade.git \
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
        eventclf \
        XAI-Library \
        convrewriting \
        git+https://github.com/guglielmocola/TwitterMonitorLib_v2.git \
        pygm \
        structify-net

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
        shuffle-graph \
        privlib \
        ash_model \
        cdlib==0.3.0 \
        bayanpy \
        dynetx==0.3.2

# -------------------------------
# SoBigData Lipari Summer School 2023 (https://sobigdata23.liparischool.it)
# -------------------------------

RUN pip install --no-cache-dir \
        tensorflow \
        exmol \
        gensim \
        joblib \
        jsonpickle \
        karateclub \
        matplotlib \
        numpy \
        pandas \
        rdkit \
        scipy \
        selfies \
        sqlalchemy \
        black \
        typing-extensions \
        torch_geometric \
        dgl \
        IPython

RUN pip install --no-cache-dir \
        torch \
        torchvision \
        torchaudio \
        --index-url https://download.pytorch.org/whl/cpu

# -------------------------------

#RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
#RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file