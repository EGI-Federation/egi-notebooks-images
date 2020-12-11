FROM eginotebooks/base

RUN mamba install -y --quiet \
        r-rpostgres\
        udunits2  \
        r-rgdal\
    && conda clean -tipsy

RUN Rscript  -e "remotes::install_github('eblondel/geoflow', dependencies = c('Depends', 'Imports'))"

RUN pip install shortid \
        nbgitpuller \
        import_ipynb \
        nbresuse 

RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
