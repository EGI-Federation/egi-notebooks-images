FROM eginotebooks/base

RUN mamba install -y --quiet \
        cftime \
        ipympl \
        jmespath \
        octave_kernel \
	octave \
    && mamba install -y --quiet pytorch torchvision -c pytorch \
    && conda clean --all

RUN conda config --add channels bioconda \
    && mamba install -y --quiet \
        biopython \
        blast \
        clustalw \
        emboss \
    && conda clean --all

# packages not in conda
RUN pip install git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                h5glance

RUN rmdir work
