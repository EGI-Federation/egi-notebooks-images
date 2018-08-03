# Starting with the image used in helm jupyterhub-v0.7-10de8dc
FROM jupyterhub/k8s-hub:b4779dc

# install d4science auth plugin for using the service in D4Science
USER root
RUN pip3 install git+https://github.com/enolfc/d4scienceauth.git@v0.2

ARG NB_USER=jovyan
USER ${NB_USER}
