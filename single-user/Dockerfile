FROM eginotebooks/base

RUN mamba install -y --quiet \
        cftime \
        ipympl \
        jmespath \
	psycopg2 \
	boto3 \
	folium \
	tensorflow \
	tqdm \
	lxml \
	pymongo \
	rasterstats \
	geopandas \
	ipywidgets \
	matplotlib \
	scipy \
	lightgbm \
	eo-learn \
	plotly \
	graphviz \
	jq \
    && mamba install -y --quiet pytorch torchvision fastai -c pytorch -c fastai \
    && conda clean --all

RUN conda config --add channels bioconda \
    && mamba install -y --quiet \
        biopython \
        blast \
        clustalw \
        emboss \
    && conda clean --all

# Octave, install on a different environment
RUN mamba create --name octave -y --quiet octave octave_kernel \
    && OCTAVE_PYTHON=$(conda run -n octave /bin/bash -c "which python") \
    && OCTAVE_PATH=$(conda run -n octave /bin/bash -c "echo \$PATH") \
    && OCTAVE_HOME=$(conda run -n octave /bin/bash -c "echo \$OCTAVE_HOME") \
    && SITE_PACKAGES=$($OCTAVE_PYTHON -c 'import site; print(site.getsitepackages().pop())') \
    && cat $SITE_PACKAGES/octave_kernel/kernel.json \
       | jq ".argv[0] = \"$OCTAVE_PYTHON\"" \
       | jq -c '. + { "env": { "PATH": "'$OCTAVE_PATH'", "OCTAVE_HOME": "'$OCTAVE_HOME'" }}' > /tmp/kernel.json \
    && mv /tmp/kernel.json $SITE_PACKAGES/octave_kernel/kernel.json \
    && jupyter kernelspec install $SITE_PACKAGES/octave_kernel --name octave --prefix /opt/conda \
    && conda clean --all

# DIRAC
RUN mamba create --name dirac -y --quiet -c conda-forge ipython dirac-grid python=2.7 pypy2.7 \
    && mkdir -p  /etc/dirac \
    && conda clean --all

COPY dirac.cfg /etc/dirac/dirac.cfg

ENV DIRACSYSCONFIG=/etc/dirac/dirac.cfg

# packages not in conda
RUN pip install git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                h5glance \
		nbtop \
		tflearn

RUN rmdir work
