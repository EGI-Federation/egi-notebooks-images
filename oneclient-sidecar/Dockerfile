FROM onedata/oneclient:20.02.7

RUN useradd -m -u 1000 -g 100 jovyan

RUN echo "user_allow_other" >> /etc/fuse.conf

USER jovyan
