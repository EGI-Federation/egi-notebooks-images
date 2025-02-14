#  ITINERIS EV (see #27742)

FROM quay.io/jupyter/datascience-notebook:r-4.3.3

USER root

RUN apt-get update && \
    apt-get install -y jq libjq-dev libxml2-dev librdf0-dev libsecret-1-dev

USER $NB_UID

RUN mamba install --channel conda-forge -y -q \
        #pkg-config \
        libsecret \
        r-base=4.3.3 \
        r-jqr \
        r-xml2 \
        r-dplyr \
        r-ggplot2 \
        r-purrr \
        r-readr \
        r-stringr \
        r-tibble \
        r-tidyr \
        r-countrycode \
        r-dtplyr \
        # geodata ? \
        r-geojsonsf \
        r-ggforce \
        r-httr2 \
        r-jsonlite \
        r-leaflet \
        r-lifecycle \
        r-lubridate \
        r-magrittr \
        r-qrcode \
        r-raster \
        r-rcolorbrewer \
        r-rdpack \
        r-rosm \
        # sf ? \
        r-spocc \
        r-stringi \
        r-taxize \
        # r-terra \ namespace ‘terra’ 1.7-83 is being loaded, but >= 1.8.5 is required
        r-tmap \
        r-units \
        r-webshot \
        r-worrms \
        r-xml \
        r-xml2 \
        # zen4R ? \
        r-lattice \
        r-latticeextra \
        r-ncdf4 \
        r-rastervis \
        r-writexl \
        r-readxl \
        r-xts \
        r-rlang \
        r-shiny \
        r-plyr \
        r-zoo \
        r-shinydashboard \
        r-data.table \
        r-lubridate \
        r-devtools \
        r-waffle \
        # ReLTER ? \
        r-rworldmap \
        r-gdalutilities \
        # V8 ? \
        r-protolite \
        r-geojson \
        r-geojsonio \
        # MODIStsp ? \
        r-rnaturalearth \
        r-xslt \
    && conda clean -tipy \
    && conda clean --all

ENV LIB_DIR='/usr/lib/x86_64-linux-gnu'
ENV INCLUDE_DIR='/usr/include -I/usr/include/raptor2 -I/usr/include/rasqal -I/usr/include/x86_64-linux-gnu'
ENV LIBRARY_PATH='/usr/lib/x86_64-linux-gnu'

RUN Rscript -e "install.packages(\
                c('geodata',\
                  'zen4R'), \
                   repos = c('http://cran.r-project.org'))"

ENV PROJ_LIB=/opt/conda/share/proj

RUN Rscript -e "install.packages(\
                c('terra'), \
                repos = c('http://cran.r-project.org'))"

RUN Rscript -e "install.packages(\
                c('ReLTER'), \
                repos = c('https://ropensci.r-universe.dev'))"

# -------------------------------
# JupyterLab extensions
# -------------------------------
RUN pip install --no-cache-dir jupyterlab-topbar
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file