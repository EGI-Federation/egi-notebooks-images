# onedata requires < py3.9
FROM jupyter/minimal-notebook:python-3.9.12

USER $NB_UID
RUN mamba install -y -c onedata -c conda-forge fs.onedatafs && conda clean --all

# packages not in conda
RUN pip install --no-cache-dir \
        git+https://github.com/EGI-Foundation/egi-notebooks-addons@0.1.3 \
        h5glance \
        nbtop \
        tflearn

RUN rmdir work
