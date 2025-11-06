FROM quay.io/jupyter/minimal-notebook:2024-04-19

# Install necessary Python packages using pip
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    xarray \
    intake \
    intake-esm \
    folium \
    hvplot \
    requests \
    ipywidgets \
    aiohttp \
    pyproj \
    pyparsing \
    zarr \
    fsspec \
    geopy \
    rooki \
    cartopy \
    xmip \
    esgf-pyclient \ 
    backports.tarfile \
    pyvista \
    pyvista[jupyter]

# Copy sample notebooks to the working directory
COPY notebooks/ /home/jovyan/work/

