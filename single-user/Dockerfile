FROM jupyter/datascience-notebook:03b897d05f16

USER root
RUN apt-get update && apt-get install -y graphviz vim

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID
RUN conda install -y r-plotly \
        r-gdata \
        rdflib \
        prov \
        graphviz \
        pydot \
        xlrd \
        lxml \
        geojson \
        proj4 \
        pydap \
        xarray \
        cartopy \
        ipyleaflet

RUN pip install shortid \
        nbgitpuller

# Overwrite cartopy with branch to fix matplotlib 3.0 compat
RUN pip install git+https://github.com/QuLogic/cartopy.git@mpl3


# Modified OWSLib
RUN git clone -b d4science https://github.com/enolfc/OWSLib.git /tmp/owslib \
    && pip install /tmp/owslib/ && rm -rf /tmp/owslib

RUN jupyter labextension install jupyter-leaflet

# R-studio
#USER root
#
#RUN apt-get update && \
#	apt-get install -y --no-install-recommends \
#        libssl1.0.0 psmisc\
#		libapparmor1 \
#		libedit2 \
#		lsb-release \
#		;
#
## You can use rsession from rstudio's desktop package as well.
#ENV RSTUDIO_PKG=rstudio-server-1.1.456-amd64.deb
#
#RUN wget -q http://download2.rstudio.org/${RSTUDIO_PKG}
#RUN dpkg -i ${RSTUDIO_PKG}
#RUN rm ${RSTUDIO_PKG}
#
#RUN apt-get clean && \
#    rm -rf /var/lib/apt/lists/*
#
## The desktop package uses /usr/lib/rstudio/bin
#ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
#ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"
#
#USER $NB_UID
#RUN pip install nbserverproxy nbrsessionproxy
#
## RUN git clone https://github.com/Viasat/nbrsessionproxy.git /tmp/nbrsessionproxy
#
#RUN jupyter serverextension enable --sys-prefix --py nbserverproxy && \
#    jupyter serverextension enable --sys-prefix --py nbrsessionproxy && \
#    jupyter nbextension install    --sys-prefix --py nbrsessionproxy && \
#    jupyter nbextension     enable  --py --sys-prefix nbrsessionproxy
##    jupyter labextension link /tmp/nbrsessionproxy/jupyterlab-rsessionproxy
#
# Allow sudo access ?
USER root
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-jovyan

USER $NB_UID
RUN rmdir work
