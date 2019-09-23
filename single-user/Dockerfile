FROM eginotebooks/base

USER root
RUN apt-get update \
    && apt-get install -y \
        nodejs \
        octave \
        libboost-python1.65.1 \
        glusterfs-common \
        libboost-context1.65.1 \
        libboost-filesystem1.65.1 \
        libboost-program-options1.65.1 \
        libboost-system1.65.1 \
        libboost-thread1.65.1 \
        libc6 \
        libcurl4 \
        libdouble-conversion1 \
        libevent-2.1-6 \
        libfuse2 \
        libgcc1 \
        libgoogle-glog0v5 \
        libpocofoundation50 \
        libpoconet50 \
        libpocoxml50 \
        libprotobuf10 \
        librados2 \
        libradosstriper1 \
        libsodium23 \
        libssl1.1 \
        libstdc++6 \
        libtbb2 \
        zlib1g \
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
                git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                git+https://github.com/enolfc/fs-onedatafs.git@notebooks \
                git+https://github.com/enolfc/onedatafs.git \
                git+https://github.com/onedata/onedatafs-jupyter.git

USER $NB_UID
RUN rmdir work

RUN jupyter lab build
