# Using julia-1.12.4 / python3.13
# Using that to ensure the image remains the same
FROM quay.io/jupyter/datascience-notebook@sha256:7e4d915319d998c5dbca911ae8ea3d7c59193aad598c75f8bf272a57d5ddfca2

#FROM jupyter/datascience-notebook:4d70cf8da953
#ARG julia_version="1.9.3"

USER root

RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID

# Add Julia packages.
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia --eval 'using Pkg; Pkg.add(["Images","VideoIO"])' && \
    julia --eval 'using Pkg; Pkg.add(url="https://github.com/gher-uliege/OceanPlot.jl",rev="master")'
    julia --eval 'using Pkg; Pkg.add(name="DIVAnd", version="2.7.14")' && \
    julia --eval 'using Pkg; Pkg.add(["JSON", "PyCall", "PyPlot", "Glob", "DataStructures", "NCDatasets"])' && \
    julia --eval 'using Pkg; Pkg.add(url="https://github.com/Alexander-Barth/CoastalCurrents.jl")' && \
    julia --eval 'using Pkg; Pkg.add("PhysOcean")'

RUN mamba install --channel conda-forge -y -q \
        rdflib \
        prov \
        graphviz \
        pydot \
        lxml \
        geojson \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
        nbgitpuller \
        basemap \
        xgboost \
        lightgbm \
        catboost \
        netcdf4 \
        aiohttp \
        graph-tool \
        dask-jobqueue \
        fs \
        rasterio \
        contextily \
        nb_conda \
        pyophidia \
	# bring dash extension hopefully
	dash \
	jupyter-server-proxy \
    && conda clean -tipy \
    && conda clean --all

RUN pip install --no-cache-dir shortid

WORKDIR "${HOME}"
