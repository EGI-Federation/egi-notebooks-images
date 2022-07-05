FROM jupyter/datascience-notebook

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install mamba -y --quiet -c conda-forge \
    && mamba install -y -q \
	cartopy \
	cachetools \
	cgen \
	coverage \
	ffmpeg \
	flake8 \
 	mpi4py \
	mpich \
	jupyter \
	netcdf4 \
	py \
	pymbolic \
 	python-dateutil \
	xarray \
	cftime \
	dask \
	pytest \
 	nbval \
	pykdtree \
	zarr 

RUN pip install --no-cache-dir git+https://github.com/OceanParcels/parcels.git@master 


RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor