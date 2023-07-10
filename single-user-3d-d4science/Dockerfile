# 3D objects management D4science                    |___/      

ARG BASE_IMAGE=eginotebooks/d4science-base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

# -------------------------------
# 3D specific libraries
# -------------------------------

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
# Jupyter lab extensions
# -------------------------------
RUN pip install --no-cache-dir \
    jupyterlab-topbar \
    jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
