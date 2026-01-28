# Use an official NVIDIA CUDA base image with dev tools and Ubuntu 22.04
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

LABEL maintainer="gianni.dallatorre@egi.eu"
LABEL description="Jupyter + PyTorch (CUDA 12.1) for Tesla V100"

# Install Python, pip, and optionally virtualenv support
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 python3.10-venv python3-pip git \
    && rm -rf /var/lib/apt/lists/*

# Make python3.10 the default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 \
 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install JupyterHub (singleuser), JupyterLab, and notebook server
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    jupyterhub

# Install PyTorch + CUDA 12.1 from PyTorch official index
RUN pip install --no-cache-dir \
    torch==2.3.0 torchvision==0.18.0 torchaudio==2.3.0 \
    --index-url https://download.pytorch.org/whl/cu121

# Optional: Create default non-root user (skip if not needed)
RUN useradd -m -s /bin/bash -N -u 1000 jovyan
USER jovyan
WORKDIR /home/jovyan
ENV PATH="/home/jovyan/.local/bin:/usr/local/nvidia/bin:${PATH}"

# Expose Jupyter port
EXPOSE 8888

# Launch JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--ServerApp.token=''"]

