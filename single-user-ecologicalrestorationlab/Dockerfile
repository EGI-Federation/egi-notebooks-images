FROM quay.io/jupyter/minimal-notebook:2024-04-19 as base

# Use uv to install python packages
RUN mamba install -y \
  netcdf4==1.6.5 \
  numpy==1.26.4 \
  openeo==0.28.0 \
  matplotlib==3.8.3 \
  xarray==2024.2.0 \
  rioxarray==0.15.1 \
  geopandas==0.14.3
