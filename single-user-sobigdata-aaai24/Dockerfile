# SoBigData AAAI 2024 (https://github.com/aiim-research/GRETEL)

ARG BASE_IMAGE=eginotebooks/d4science-base:latest

FROM $BASE_IMAGE

USER $NB_UID

ARG SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

# -------------------------------
# SoBigData Lipari Summer School 2023
# -------------------------------

RUN pip install --no-cache-dir \
        tensorflow \
        exmol \
        gensim \
        joblib \
        jsonpickle \
        karateclub \
        matplotlib \
        numpy \
        pandas \
        rdkit \
        scipy \
        selfies \
        sqlalchemy \
        black \
        typing-extensions \
        torch_geometric \
        dgl \
        IPython \
        networkx \
        networksns \
        picologging==0.9.2 \
        scikit-learn \
        ipykernel \
        flufl.lock \
        jsonc-parser

RUN pip install --no-cache-dir \
        torch \
        torchvision \
        torchaudio \
        --index-url https://download.pytorch.org/whl/cpu

#RUN mamba install -y protobuf==4.23.3

RUN mamba update --all
RUN mamba update -n base -c defaults conda -y
RUN mamba create -n GRTL python=3.9 -y
RUN mamba init bash
#RUN conda activate GRTL
RUN echo "conda activate GRTL" >> ~/.bashrc

# -------------------------------
# Jupyter lab extensions
# -------------------------------
RUN pip install --no-cache-dir \
    jupyterlab-topbar \
    jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file