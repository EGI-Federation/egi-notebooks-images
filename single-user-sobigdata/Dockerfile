FROM eginotebooks/base

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
   && conda clean --all

RUN  mamba install -y pytorch==1.6.0  torchtext torchvision -c pytorch \
   && conda clean --all

RUN pip install \
        import_ipynb \
        nbresuse \
        opencv-python \
        simpletransformers \
        shuffle-graph 


#RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
#RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
