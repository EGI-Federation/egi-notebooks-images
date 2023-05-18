FROM onedata/oneclient:21.02.1

RUN useradd -m -u 1000 -g 100 jovyan

RUN echo "user_allow_other" >> /etc/fuse.conf

USER jovyan
