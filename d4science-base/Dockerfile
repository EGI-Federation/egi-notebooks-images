# 4d70cf8da953 has python3.10.11
# Using that to ensure the image remains the same
FROM jupyter/datascience-notebook:4d70cf8da953
ARG julia_version="1.9.3"

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

# -----------------------------------------------------------------------------
# Julia setup - we need a newer version than the one in the base
# Julia dependencies
# install Julia packages in /opt/julia instead of ${HOME}
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia \
    JULIA_VERSION="${julia_version}"

WORKDIR /tmp

# hadolint ignore=SC2046
RUN set -x && \
    julia_arch=$(uname -m) && \
    julia_short_arch="${julia_arch}" && \
    if [ "${julia_short_arch}" == "x86_64" ]; then \
      julia_short_arch="x64"; \
    fi; \
    julia_installer="julia-${JULIA_VERSION}-linux-${julia_arch}.tar.gz" && \
    julia_major_minor=$(echo "${JULIA_VERSION}" | cut -d. -f 1,2) && \
    mkdir "/opt/julia-${JULIA_VERSION}" && \
    wget -q "https://julialang-s3.julialang.org/bin/linux/${julia_short_arch}/${julia_major_minor}/${julia_installer}" && \
    tar xzf "${julia_installer}" -C "/opt/julia-${JULIA_VERSION}" --strip-components=1 && \
    rm "${julia_installer}" && \
    ln -fs /opt/julia-${JULIA_VERSION}/bin/julia /usr/local/bin/julia

# Show Julia where conda libraries are \
RUN rm -rf /etc/julia && mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"${CONDA_DIR}/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    rm -rf "${JULIA_PKGDIR}" && \
    mkdir "${JULIA_PKGDIR}" && \
    chown "${NB_USER}" "${JULIA_PKGDIR}" && \
    fix-permissions "${JULIA_PKGDIR}"

USER $NB_UID

# Add Julia packages.
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("HDF5")' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    julia --eval 'using Pkg; Pkg.pin("IJulia")' && \
    # move kernelspec out of home \
    mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    rm -rf "${HOME}/.local" && \
    fix-permissions "${JULIA_PKGDIR}" "${CONDA_DIR}/share/jupyter" && \
    julia --eval 'using Pkg; Pkg.add(["Images","VideoIO"])' && \
    julia --eval 'using Pkg; Pkg.add(url="https://github.com/gher-uliege/OceanPlot.jl",rev="master")'
    julia --eval 'using Pkg; Pkg.add(name="DIVAnd", version="2.7.14")' && \
    julia --eval 'using Pkg; Pkg.add(["JSON", "PyCall", "PyPlot", "Glob", "DataStructures", "NCDatasets"])' && \
    julia --eval 'using Pkg; Pkg.add(url="https://github.com/Alexander-Barth/CoastalCurrents.jl")' && \
    julia --eval 'using Pkg; Pkg.add("PhysOcean")'

# end Julia Setup
# -----------------------------------------------------------------------------


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
