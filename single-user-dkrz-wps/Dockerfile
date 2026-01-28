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

# Copy example notebooks to a fixed path inside the container.
# These notebooks are provided as read-only examples for users.
COPY example_notebooks /opt/example_notebooks
