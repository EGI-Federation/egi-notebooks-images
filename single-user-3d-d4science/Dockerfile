# 3D objects management D4science                    |___/      

ARG BASE_IMAGE=eginotebooks/d4science-base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

#RUN apt-get update \
#    && apt-get install --no-install-recommends -y \
#        nco \
#        cdo \
#        cmake \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*
#
#USER $NB_UID
#
#RUN mamba install -y --quiet \
#        basemap \
#        beakerx \
#        xgboost \
#        lightgbm \
#        catboost \
#        netcdf4 \
#        aiohttp \
#        graph-tool \
#        scikit-learn==0.22.1 \
#        scikit-mobility \
#        dask-jobqueue \
#        fs \
#        rasterio \
#        contextily \
#        nb_conda_kernels \
#        nb_conda \
#    && conda clean -tipsy

# Pinned networkx to 2.6.3 as 2.7 makes networksns fail
#RUN pip install --no-cache-dir \
#        bicm \
#        rdp \
#        sentinelhub \
#        import_ipynb \
#        nbresuse \
#        ndlib \
#        motuclient \
#        panel==0.9.* \
#        cdlib[C]==0.2.3 \
#        cython \
#        node_conformity \
#        git+https://github.com/geopython/OWSLib.git \
#        git+https://github.com/guglielmocola/RetweetCascade.git \
#        fast-forward-indexes \
#        NEMtropy \
#        folium==0.11.0 \
#        geopy==2.0.0 \
#        hvplot==0.6.0 \
#        intake==0.6.0 \
#        intake-esm==2020.8.15 \
#        hda \
#        seaborn==0.11.0 \
#        zarr==2.5.0 \
#        holoviews \
#        networkx==2.6.3 \
#        networksns \
#        eventclf \
#        XAI-Library \
#        convrewriting \
#        git+https://github.com/guglielmocola/TwitterMonitorLib_v2.git \
#        pygm \
#        structify-net

# -------------------------------
# 3D specific libraries
# -------------------------------
#RUN mamba install -y --quiet \
#        pyspark \
#        pyfim \
#        pyclustering \
#        transformers \
#        rtree \
#        geopandas \
#        nltk \
#        pydotplus \
#        plotly \
#        graphviz \
#        keras \
#        selenium \
#        tweepy \
#        openjdk=8 \
#   && conda clean --all
#
#RUN  mamba install -y pytorch==1.6.0  torchtext torchvision -c pytorch \
#   && conda clean --all

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgraphicsmagick++1-dev \
        libboost-python-dev \
        g++ \
        python3-pgmagick \
        && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
        open3d \
        trimesh \
        pyvista \
        vedo \
        pymeshlab \
        pyCloudCompareCLI \
        numpy \
        pandas \
        opencv-python \
        Matplotlib \
        Pillow \
        Scipy
# -------------------------------

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
