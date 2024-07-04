ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mamba install -y --quiet \
	nb_conda_kernels \
	cudatoolkit=11.4.2 \
	cudnn \
        matplotlib \
        lightgbm \
        plotly \
        graphviz \
        jq \
    && conda clean --all

# not installable from mamba for now
RUN pip install  --no-cache-dir \
        eo-learn

# Octave, install on a different environment
# Octave from conda won't build packages
# see https://discourse.jupyter.org/t/installing-octave-packages-with-binder/4206
USER root

RUN apt-get update \
    && apt-get install --install-recommends -y \
        octave octave-signal gnuplot\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet octave_kernel=0.32.0 \
    && conda clean --all

# Rstudio
USER root
RUN apt-get update \
    && apt-get install -y gdebi-core \
    && wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb \
    && gdebi -n rstudio-server-2022.07.2-576-amd64.deb \
    && rm rstudio-server-2022.07.2-576-amd64.deb \
    && apt-get remove -y gdebi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet \
       -c conda-forge jupyter-rsession-proxy \
    && conda clean --all


# packages not in conda
RUN pip install --no-cache-dir \
        git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
	bokeh==3.0.2 \
	panel \
	jupyterlab-git \
	jupyterlab-github \
	mlflow \
	fastai \
	papermill \
	tensorflow \
	jupyter-tensorboard-proxy \
	mlflow-server-proxy \
	protobuf==4.21.9 \
	# torch==1.12.1+cu113 \
	# torchvision==0.13.1+cu113 \
	# torchaudio==0.12.1 \
	--extra-index-url https://download.pytorch.org/whl/cu113

ENV LD_LIBRARY_PATH="${CONDA_DIR}/lib:${LD_LIBRARY_PATH}"

RUN rmdir work
