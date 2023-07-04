#   _____       ____  _       _____        _
#  / ____|     |  _ \(_)     |  __ \      | |
# | (___   ___ | |_) |_  __ _| |  | | __ _| |_ __ _ _| |_ _| |_
#  \___ \ / _ \|  _ <| |/ _` | |  | |/ _` | __/ _` |_   _|_   _|
#  ____) | (_) | |_) | | (_| | |__| | (_| | || (_| | |_|   |_|
# |_____/ \___/|____/|_|\__, |_____/ \__,_|\__\__,_|
#                        __/ |
#                       |___/

ARG BASE_IMAGE=eginotebooks/d4science-base:latest

FROM $BASE_IMAGE

USER $NB_UID

ARG SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True


# -------------------------------
# SoBigData Lipari Summer School 2023 (https://sobigdata23.liparischool.it)
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
        IPython

RUN pip install --no-cache-dir \
        torch \
        torchvision \
        torchaudio \
        --index-url https://download.pytorch.org/whl/cpu

RUN mamba install -y protobuf==4.23.3
# -------------------------------

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
