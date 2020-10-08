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

USER root
RUN apt-get update \
    && apt-get install -y gnupg \
    && curl http://repository.egi.eu/sw/production/cas/1/current/repo-files/egi-trustanchors.list \
            -o /etc/apt/sources.list.d/egi-trustanchors.list \
    && curl https://dl.igtf.net/distribution/igtf/current/GPG-KEY-EUGridPMA-RPM-3 | apt-key add - \
    && apt-get update \
    && apt-get install -y ca-policy-egi-core \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p  /etc/dirac
COPY dirac.cfg /etc/dirac/dirac.cfg
ENV DIRACSYSCONFIG=/etc/dirac/dirac.cfg

USER $NB_UID

RUN mamba create --name dirac -y --quiet -c conda-forge ipython dirac-grid python=2.7 pypy2.7 ipykernel \
    && $(conda run -n dirac /bin/bash -c "which python") -m ipykernel install --prefix /tmp --name DIRAC \
    && jupyter kernelspec install /tmp/share/jupyter/kernels/dirac/ --name DIRAC --prefix /opt/conda \
    && rm -rf /tmp/share \
    && conda clean --all


# packages not in conda
RUN pip install git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                h5glance \
		nbtop \
		tflearn

RUN rmdir work
