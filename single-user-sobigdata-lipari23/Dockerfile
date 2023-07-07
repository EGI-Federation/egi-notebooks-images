# SoBigData Lipari Summer School 2023 (https://sobigdata23.liparischool.it)

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
        networkx==2.6.3 \
        networksns

RUN pip install --no-cache-dir \
        torch \
        torchvision \
        torchaudio \
        --index-url https://download.pytorch.org/whl/cpu

RUN mamba install -y protobuf==4.23.3

# -------------------------------

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
