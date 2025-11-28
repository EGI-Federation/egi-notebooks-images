
FROM quay.io/jupyter/minimal-notebook AS base

RUN mamba install --yes -c conda-forge \
    python==3.13 \
    folium==0.20.0 \
    ipympl==0.9.8 \
    numpy==2.3.5 \
    xarray==2025.11.0 \
    cmocean==4.0.3 \
    cartopy==0.25.0 \
    ipywidgets==8.1.8 \
    matplotlib==3.10.8 \
    pyproj==3.7.2 \
    geopandas==1.1.1 \
    pandas==2.3.3 \
    openpyxl==3.1.5 \
    seaborn==0.13.2 \
    netCDF4==1.7.3 \
    plotly==6.5.0 \
    && pip install openeo copernicusmarine==2.2.5
