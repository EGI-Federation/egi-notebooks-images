ARG BASE_IMAGE=eginotebooks/d4science-base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y \
        nco \
        cdo \
        gdal-bin \
        cmake \
        libgdal-dev \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda create --quiet --yes -n java8 \
    && mamba install -n java8 --yes openjdk=8 \
    && conda clean -tipy

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Installing torch explictly to have only CPU version
RUN pip install --index-url https://download.pytorch.org/whl/cpu \
	torch torchvision torchaudio


# cdlib[C]==0.2.3 is too old for this env, so unpinning
RUN pip install --no-cache-dir \
        bicm \
        rdp \
        oceans \
        sentinelhub \
        import_ipynb \
        nbresuse \
        ndlib \
        motuclient \
        panel==0.9.* \
        cdlib[C] \
        cython \
        node_conformity \
        git+https://github.com/obidam/pyxpcm.git \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/euroargodev/argopy.git@master \
        git+https://github.com/guglielmocola/RetweetCascade.git@f96319d0107473715104acceb2ff0925d35dd9e3 \
        fast-forward-indexes \
        NEMtropy \
        geopy==2.0.0 \
        hvplot==0.6.0 \
        intake==0.6.0 \
        intake-esm==2020.8.15 \
        hda \
        seaborn==0.11.0 \
        zarr \
        holoviews \
        networksns \
        GDAL==$(gdal-config --version) \
        copernicusmarine

# Julia Updates and packages installations
# See https://support.d4science.org/issues/22065
RUN julia --eval 'using Pkg; Pkg.pin("IJulia")' \
    && julia --eval "using Pkg; Pkg.update()" \
    && julia --eval 'using Pkg; Pkg.add(["Images","VideoIO"])' \
    && julia --eval 'using Pkg; Pkg.add(url="https://github.com/gher-ulg/DIVAndNN.jl")' \
    && julia --eval 'using Pkg; Pkg.add(name="DIVAnd", version="2.7.9")' \
    && julia --eval 'using Pkg; Pkg.add(["JSON", "PyCall", "PyPlot", "Glob", "DataStructures", "NCDatasets"])' \
    && julia --eval 'using Pkg; Pkg.add(url="https://github.com/Alexander-Barth/CoastalCurrents.jl")' \
    && julia --eval 'using Pkg; Pkg.add("PhysOcean")' \
    && julia --eval 'using Pkg; \
                     Pkg.add(["CSV", "DataFrames", "Revise", "Compat", "Dates", \
                              "Statistics", "Logging", "Random", "Printf", "FileIO", \
			      "Missings", "Distributed", "Profile", "StatsBase", \
			      "JLD2", "Interpolations"]);'

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir \
    jupyterlab-topbar \
    jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
RUN jupyter lab build
