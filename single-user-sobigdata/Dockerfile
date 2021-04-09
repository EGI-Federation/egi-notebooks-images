ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

RUN mamba install -y --quiet \
        pyspark \
        pyfim \
        pyclustering \
        transformers \
        rtree \
        geopandas \
        nltk \
        pydotplus \
        plotly \
        graphviz \
        keras \
        selenium \
        tweepy \
        openjdk=8 \
   && conda clean --all

RUN  mamba install -y pytorch==1.6.0  torchtext torchvision -c pytorch \
   && conda clean --all

RUN pip install --no-cache-dir \
        import_ipynb \
        nbresuse \
        opencv-python \
        simpletransformers \
        shuffle-graph 

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
