ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mamba install -y --quiet \
         \
        # resource usage info in GUI
         \
    && conda clean --all

# See https://github.com/mamba-org/mamba/issues/336
# pytorch is not installing properly with mamba
RUN mamba install -y pytorch torchvision torchaudio cpuonly -c pytorch -c anaconda -c conda-forge \
    && mamba install -y -q fastai -c fastai \
    && mamba install -y -q jupyter-resource-usage=1.2.0 \
    && conda clean --all

# packages not in conda or their latest versions
RUN pip install --no-cache-dir \
        tflearn \
        eo-learn \
        tensorflow \
        elyra \
        git+https://gitlab.cesnet.cz/702/projekty/notebooks-customizations/jupyterlab-token-acquirer

RUN jupyter lab build

RUN rmdir work
