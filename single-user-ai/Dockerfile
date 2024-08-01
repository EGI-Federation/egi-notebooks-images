ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# not installable from mamba for now
RUN pip install --no-cache-dir \
        elyra

RUN jupyter lab build

RUN rmdir work
