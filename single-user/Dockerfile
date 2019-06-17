FROM eginotebooks/base

USER root
RUN apt-get update \
    && apt-get install -y \
        nodejs \
        octave \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID
RUN conda install -y --quiet \
        cftime \
        ipympl \
        jmespath \
        octave_kernel \
        simplegeneric \
    && conda remove rpy2 \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# packages not in conda
RUN pip install rpy2

USER $NB_UID
RUN rmdir work
