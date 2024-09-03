# Use the Jupyter base notebook image as the base image
FROM quay.io/jupyter/base-notebook:latest

# Maintainer of this dockerfile 
LABEL org.opencontainers.image.authors="Irfan Khan"

# Switch to root user to install packages
USER root

# Install mamba
RUN pip install mamba

# Install necessary packages directly into the base environment
RUN mamba install -c conda-forge \
    numpy \
    pandas \
    xarray \
    intake \
    intake-esm \
    geopy \
    folium \
    hvplot \
    fsspec \
    aiohttp \
    requests \
    netcdf4 \
    openeo \
    matplotlib \
    rioxarray \
    geopandas \
    zarr \
    rooki \
    ipywidgets\
    --yes

# Copy example notebooks into the container
COPY ./notebooks /home/jovyan/work/

# Switch back to the default jovyan user
USER ${NB_UID}

# Expose the default JupyterLab port
EXPOSE 8888

# Set the command to start JupyterLab when the container starts
CMD ["start-notebook.sh"]
