FROM eginotebooks/base

USER root
RUN apt-get update \
    && apt-get install -y \
        nodejs \
        octave \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# onedata
RUN curl -sSL http://packages.onedata.org/onedata.gpg.key | apt-key add - \
    && echo "deb [arch=amd64] http://packages.onedata.org/apt/ubuntu/1802 bionic main" > /etc/apt/sources.list.d/onedata.list \
    && apt-get update && apt-get install -y python3-onedatafs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID
RUN conda install -y --quiet \
        cftime \
        ipympl \
        jmespath \
        octave_kernel \
        simplegeneric \
        fs \
    && conda remove rpy2 \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# packages not in conda
RUN pip install rpy2 \
                onedata-fs \
                git+https://github.com/onedata/onedatafs-jupyter.pip

USER $NB_UID
RUN rmdir work
