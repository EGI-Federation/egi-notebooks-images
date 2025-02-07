#  ITINERIS EV (see #27742)

FROM quay.io/jupyter/datascience-notebook:r-4.3.3

USER root

RUN apt-get update && \
    apt-get install -y jq libjq-dev

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
