FROM jupyter/datascience-notebook:59c973d16bca

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install mamba -y --quiet -c conda-forge \
    && mamba install -y -q \
        tensorflow \
        tensorboard \
        wandb \
        transformers \
        datasets \
        sentencepiece \
        captum \
        scikit-learn \
        scipy \
        numpy \
        pandas \
        matplotlib \
        pytorch torchvision \
        pytorch-lightning \
    && mamba install -y -q pyg -c pyg

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor

