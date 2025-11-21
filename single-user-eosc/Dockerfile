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
	plotly \
	graphviz \
	jq \
	nb_conda_kernels \
        # resource usage info in GUI
        jupyter-resource-usage=1.2.0 \
        jupyter-ai=2.31.6 \
    && conda clean --all

# Octave, install on a different environment
# Octave from conda won't build packages
# see https://discourse.jupyter.org/t/installing-octave-packages-with-binder/4206
USER root

RUN apt-get update \
    && apt-get install --install-recommends -y \
        octave octave-signal gnuplot\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet octave_kernel=0.32.0 \
    && conda clean --all

# Rstudio
USER root
RUN apt-get update \
    && apt-get install -y gdebi-core \
    && wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.12.1-563-amd64.deb \
    && gdebi -n rstudio-server-2024.12.1-563-amd64.deb \
    && rm rstudio-server-2024.12.1-563-amd64.deb \
    && apt-get remove -y gdebi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet \
       -c conda-forge jupyter-rsession-proxy \
    && conda clean --all

# packages not in conda
RUN pip install --no-cache-dir \
        h5glance \
        nbtop \
        panel

# EOSC customisation
# TODO: trigger image build on changes to these files
COPY eosc /opt/conda/share/eosc
RUN set -x \
    && export PKG_PATH="$(python -c 'import jupyter_server; print(jupyter_server.__path__[0])')" \
    && mkdir -p "$PKG_PATH/static/custom/logo" \
    && ln -s /opt/conda/share/eosc/custom.css "$PKG_PATH/static/custom/" \
    && ln -s /opt/conda/share/eosc/eosc-ntb-logo.svg "$PKG_PATH/static/custom/logo" \
    && mkdir -p /opt/conda/share/jupyter/lab/settings/ \
    && ln -sf /opt/conda/share/eosc/overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json

RUN jupyter lab build

RUN rmdir work

# brew
USER root
RUN useradd -m -s /bin/bash linuxbrew
USER linuxbrew
RUN /bin/bash -c "HOME=/home/linuxbrew $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
USER root
RUN chmod 777 /home/linuxbrew && chown -R "$NB_UID" /home/linuxbrew/.linuxbrew

USER $NB_UID
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Turn off brew analytics
RUN brew analytics off