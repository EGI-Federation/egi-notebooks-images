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
    && mamba install -y -q jupyter-collaboration \
    && conda clean --all

# packages not in conda or their latest versions
RUN pip install --no-cache-dir \
        tflearn \
        eo-learn \
        tensorflow \
        elyra \
        # share-manager extensions
        git+https://gitlab.cesnet.cz/702/projekty/eosc-notebooks/jupyterlab-token-acquirer \
        git+https://gitlab.cesnet.cz/702/projekty/eosc-notebooks/user-sharing-extension

RUN jupyter lab build

RUN rmdir work
