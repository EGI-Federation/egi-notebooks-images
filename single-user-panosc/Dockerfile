FROM jupyter/minimal-notebook:ubuntu-18.04

USER $NB_UID
RUN conda install mamba -y --quiet -c conda-forge 
RUN mamba install -y  -c onedata protobuf=3.13 fs.onedatafs && conda clean --all


# packages not in conda
RUN pip install git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
                h5glance \
		nbtop \
		tflearn \
                shortid \
                nbgitpuller 

RUN rmdir work
