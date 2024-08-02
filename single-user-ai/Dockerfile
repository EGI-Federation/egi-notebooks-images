ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mamba install -y --quiet \
        tensorflow \
    && conda clean --all

# See https://github.com/mamba-org/mamba/issues/336
# pytorch is not installing properly with mamba
RUN mamba install -y pytorch torchvision torchaudio cpuonly -c pytorch -c anaconda -c conda-forge \
    && mamba install -y --quiet fastai -c fastai \
    && conda clean --all

# packages not in conda
RUN pip install --no-cache-dir \
        tflearn

# not installable from mamba for now
RUN pip install --no-cache-dir \
        eo-learn

# not installable from mamba for now
RUN pip install --no-cache-dir \
        elyra

RUN jupyter lab build

RUN rmdir work
