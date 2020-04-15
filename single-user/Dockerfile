FROM eginotebooks/base

USER root
RUN apt-get -qq update \
    && apt-get -qq install -y \
        nodejs \
        octave \
        libboost-python1.65.1 \
        glusterfs-common \
        libboost-context1.65.1 \
        libboost-filesystem1.65.1 \
        libboost-program-options1.65.1 \
        libboost-system1.65.1 \
        libboost-thread1.65.1 \
        libboost-regex1.65.1 \
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
                git+https://github.com/onedata/fs-onedatafs.git@feature/VFS-6264-fix-onedatafs-h5py-support \
                git+https://github.com/enolfc/onedatafs@19.02.1 \
                git+https://github.com/onedata/onedatafs-jupyter.git@19.02.1 \
                h5glance

RUN rmdir work
