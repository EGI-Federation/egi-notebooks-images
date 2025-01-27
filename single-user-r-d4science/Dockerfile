FROM jupyter/datascience-notebook:7e1a19a8427f

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID

RUN pip install --no-cache-dir shortid

RUN mamba install -y -q \
        rdflib \
        prov \
        graphviz \
        pydot \
        lxml \
        geojson \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
        nbgitpuller \
        r-plotly \
        r-gdata \
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
        r-pastecs \
        r-factominer \
        r-ggpubr \
    && conda clean -tipy

RUN Rscript  -e "remotes::install_github('eblondel/geoflow', \
                 dependencies = c('Depends', 'Imports'))"

RUN Rscript  -e "install.packages(\
		 c('geometa', \
		   'ggplot2', \
		   'xts', \
		   'reshape2', \
		   'lubridate', \
		   'stats', \
		   'plyr', \
		   'dplyr', \
		   'RColorBrewer', \
		   'viridis', \
		   'parallel', \
		   'doParallel', \
		   'foreach', \
		   'knitr', \
		   'remotes', \
		   'mgcv', \
		   'seacarb', \
                   'ows4R', \
                   'geonapi', \
                   'geosapi', \
                   'raster', \
                   'virtualspecies', \
                   'abind', \
                   'feather', \
                   'reticulate', \
                   'mvrsquared', \
                   'RPostgreSQL', \
                   'Shinybusy', \
                   'TropFishR', \
		   'solrad'), \
                    repos = c('http://cran.r-project.org'))"

RUN Rscript  -e "remotes::install_github('lifewatch/lwdataexplorer', \
                 dependencies = c('Depends', 'Imports'))"

RUN pip install --no-cache-dir \
        import_ipynb \
        nbresuse \
	git+https://github.com/supsi-dacd-isaac/mbtr.git
