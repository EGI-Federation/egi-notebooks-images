FROM eginotebooks/base

USER root
RUN apt-get -qq update \
    && apt-get -qq install -y \
        nodejs \
        octave \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet \
        cftime \
        ipympl \
        jmespath \
        octave_kernel \
        fs \
    && conda clean -tipsy

RUN conda config --add channels bioconda \
    && mamba install -y --quiet \
        biopython \
        blast \
        clustalw \
        emboss

# packages not in conda
RUN pip install git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                h5glance

RUN rmdir work
