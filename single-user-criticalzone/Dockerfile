# CriticalZone


ARG BASE_IMAGE=eginotebooks/base:latest
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
        gdal-bin \
        g++ \
        python3-gdal \
        libgdal-dev \
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
        numpy \
        GDAL=="$(gdal-config --version).*" \
        h5netcdf

#RUN conda install -c conda-forge gdal

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir jupyterlab-topbar
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
