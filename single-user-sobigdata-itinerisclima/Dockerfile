#  ITINERIS CLIMA (see #27991)

ARG BASE_IMAGE=eginotebooks/base:latest
FROM $BASE_IMAGE

USER root

RUN apt update \
    && apt install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
        g++ \
        libcurl4-openssl-dev \
        libssl-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install --no-cache-dir \
        zarr \
        holoviews \
        hvplotC \
        cf_xarray \
        intake \
        intake_esm \
        panel \
        copernicusmarine

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir jupyterlab-topbar
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file