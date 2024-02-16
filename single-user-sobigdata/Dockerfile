FROM quay.io/jupyter/minimal-notebook:x86_64-2024-02-12

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

COPY conda-lock.yml /conda/conda-lock.yml

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda create --name lock -c conda-forge conda-lock --yes && \
    conda activate lock && \
    conda-lock install --mamba --copy --name sbd /conda/conda-lock.yml && \
    conda activate sbd && \
    pip install privlib && \
    pip install git+https://github.com/guglielmocola/RetweetCascade.git && \
    pip install git+https://github.com/guglielmocola/TwitterMonitorLib_v2.git && \
    pip install git+https://github.com/vitiugin/cliqs.git && \
    pip install -i https://test.pypi.org/pypi/ --extra-index-url https://pypi.org/simple \
	anonymization-crisesURV \
	antiDiscrimination-crisesURV && \
    conda clean --all --force-pkgs-dirs --yes && \
    pip cache purge

WORKDIR "${HOME}"
