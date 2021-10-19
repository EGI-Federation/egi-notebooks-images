ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

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

# Octave, install on a different environment
RUN mamba create --name octave -y --quiet octave octave_kernel \
    && OCTAVE_PYTHON=$(conda run -n octave /bin/bash -c "which python") \
    && OCTAVE_PATH=$(conda run -n octave /bin/bash -c "echo \$PATH") \
    && OCTAVE_HOME=$(conda run -n octave /bin/bash -c "echo \$OCTAVE_HOME") \
    && SITE_PACKAGES=$($OCTAVE_PYTHON -c 'import site; print(site.getsitepackages().pop())') \
    && jq ".argv[0] = \"$OCTAVE_PYTHON\""  < "$SITE_PACKAGES/octave_kernel/kernel.json" \
       | jq -c '. + { "env": { "PATH": "'"$OCTAVE_PATH"'", "OCTAVE_HOME": "'"$OCTAVE_HOME"'" }}' > /tmp/kernel.json \
    && mv /tmp/kernel.json "$SITE_PACKAGES/octave_kernel/kernel.json" \
    && jupyter kernelspec install "$SITE_PACKAGES/octave_kernel" --name octave --prefix /opt/conda \
    && conda clean --all

RUN conda config --add channels bioconda \
    && mamba install -y --quiet \
        biopython \
        blast \
        clustalw \
        emboss \
    && conda clean --all

# packages not in conda
RUN pip install --no-cache-dir \
        git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
        h5glance \
        nbtop \
        tflearn

# EMSO
# python3.7, install on a different environment
RUN mamba create --name python3.7 -y --quiet -c conda-forge ipython python=3.7 ipykernel \
    && $(conda run -n python3.7 /bin/bash -c "which python") -m ipykernel install --prefix /tmp --name Python-3.7 \
    && jupyter kernelspec install /tmp/share/jupyter/kernels/python-3.7/ --name Python-3.7 --prefix /opt/conda \
    && rm -rf /tmp/share \
    && conda clean --all

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        libsndfile1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Avoid a broken extension to show up
RUN jupyter labextension disable @pyviz/jupyterlab_pyviz

RUN rmdir work
