# CriticalZone


ARG BASE_IMAGE=eginotebooks/d4science-base:latest
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

RUN pip install --no-cache-dir \
        xarray \
        rioxarray \
        netCDF4 \
        pandas \
        scipy \
        matplotlib \
        gdal \
        h5netcdf

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir jupyterlab-topbar
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
