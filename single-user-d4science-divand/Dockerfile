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
        emacs-nox \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Julia Updates and packages installations
# See https://support.d4science.org/issues/22065
RUN julia --eval 'using Pkg; Pkg.pin("IJulia")' \
    && julia --eval "using Pkg; Pkg.update()" \
    && julia --eval 'using Pkg; Pkg.add(name="DIVAnd", version="2.7.14")' \
    && julia --eval 'using Pkg; Pkg.add([ \
       "CSV", \
       "Compat", \
       "DataFrames", \
       "DataStructures", \
       "Dates", \
       "Distributed", \
       "FileIO", \
       "Glob", \
       "Images", \ 
       "Interpolations", \
       "JLD2", \
       "JSON", \
       "Logging", \
       "Missings", \
       "NCDatasets", \
       "Parquet2", \
       "PhysOcean", \
       "Printf", \
       "Profile", \
       "PyCall", \
       "PyPlot", \
       "Random", \
       "Revise", \
       "Statistics", \
       "StatsBase", \
       "VideoIO", \
       ]);' \
    && cd /tmp \
    && git clone https://github.com/AbelDechN/CoastalCurrents.jl \
    && cd CoastalCurrents.jl \
    && julia --project=. --eval "using Pkg; Pkg.instantiate()"

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir \
    jupyterlab-topbar \
    jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
RUN jupyter lab build
