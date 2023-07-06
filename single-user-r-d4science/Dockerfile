ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

RUN mamba install -y --quiet \
        r-rpostgres \
        r-geojsonio \
        r-rlang  \
        r-rcpp \
    && conda clean -tipy

RUN mamba install -y --quiet \
        r-vctrs \
        r-pillar \
        r-magrittr \
        r-fansi \
        r-crayon \
        r-cli \
        r-dbi \
        r-cpp11 \
        r-bh \
    && conda clean -tipy

RUN mamba install -y --quiet \
        r-tibble \
        r-hms \
        r-jsonlite \
        r-zip \
        udunits2  \
        r-rgdal \
        r-pastecs \
        r-factominer \
    && conda clean -tipy

RUN Rscript  -e "remotes::install_github('eblondel/geoflow', dependencies = c('Depends', 'Imports'))"

RUN Rscript  -e "install.packages(c('geometa','ows4R','geonapi','geosapi','raster','virtualspecies','abind','feather','reticulate','mvrsquared','RPostgreSQL','Shinybusy','TropFishR'), repos = c('http://cran.r-project.org'))"

RUN pip install --no-cache-dir \
        import_ipynb \
        nbresuse \
        git+https://github.com/andrea-manzi/mbtr.git
