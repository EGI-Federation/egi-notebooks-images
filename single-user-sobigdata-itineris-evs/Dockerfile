#  ITINERIS EV (see #27742)

ARG BASE_IMAGE=eginotebooks/base:latest
FROM $BASE_IMAGE

USER root

RUN apt update \
    && apt install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
        g++ \
        libcurl4-openssl-dev \
        libssl-dev \
        libjq-dev \
        librdf0-dev \
        libudunits2-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN Rscript  -e "install.packages(\
                 c('dplyr',\
                   'ggplot2', \
                   'purrr', \
                   'readr', \
                   'stringr', \
                   'tibble', \
                   'tidyr', \
                   'countrycode', \
                   'dtplyr', \
                   'geodata', \
                   'geojsonsf', \
                   'ggforce', \
                   'httr2', \
                   'jqr', \
                   'jsonlite', \
                   'leaflet', \
                   'lifecycle', \
                   'lubridate', \
                   'magrittr', \
                   'qrcode', \
                   'raster', \
                   'RColorBrewer', \
                   'Rdpack', \
                   'rosm', \
                   'sf', \
                   'spocc', \
                   'stringi', \
                   'taxize', \
                   'terra', \
                   'tmap', \
                   'units', \
                   'webshot', \
                   'worrms', \
                   'XML', \
                   'xml2', \
                   'zen4R', \
                   'lattice', \
                   'latticeExtra', \
                   'ncdf4', \
                   'rasterVis', \
                   'writexl', \
                   'readxl', \
                   'xts', \
                   'rlang', \
                   'Shiny', \
                   'plyr', \
                   'zoo', \
                   'shinydashboard', \
                   'data.table', \
                   'lubridate', \
                   'devtools', \
                   'waffle'), \
                    repos = c('http://cran.r-project.org'))"

RUN Rscript -e "utils::install.packages('ReLTER', \
                repos = 'https://ropensci.r-universe.dev')"


#RUN Rscript  -e "devtools::install_github('ropensci/ReLTER', \
#                'rspatial/geodata', \
#                'ropensci/MODIStsp')"

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir jupyterlab-topbar
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
