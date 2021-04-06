FROM eginotebooks/base

RUN mamba install -y --quiet \
        r-rpostgres \
        r-geojsonio \
        r-rlang  \
        r-rcpp \
        r-vctrs \
        r-pillar \
        r-magrittr \
        r-fansi \
        r-crayon \
        r-cli \
        r-dbi \
        r-cpp11 \
        r-bh \
        r-tibble \
        r-hms \
        r-jsonlite \
        r-zip \
        udunits2  \
        r-rgdal \
    && conda clean -tipsy

RUN Rscript  -e "remotes::install_github('eblondel/geoflow', dependencies = c('Depends', 'Imports'))"

RUN Rscript  -e "install.packages(c('geometa','ows4R','geonapi','geosapi'), repos = c('http://cran.r-project.org'))"

RUN pip install --no-cache-dir \
	shortid \
        nbgitpuller \
        import_ipynb \
        nbresuse 

RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
