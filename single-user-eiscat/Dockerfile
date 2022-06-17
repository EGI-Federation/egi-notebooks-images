FROM jupyter/base-notebook:latest

USER root
WORKDIR /root

# install eiscat tools
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install --no-install-recommends -y \
 vim wget curl \
 bzip2 lbzip2 octave ffmpeg \
 gcc libc6-dev libfftw3-3 libgfortran5 \
 python3 python3-pip python3-matplotlib \
 && apt-get clean \
 && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

ADD pkgs/*.deb /tmp/
RUN for i in /tmp/*deb; do dpkg -i $i && rm $i; done
COPY pkgs/*.tar.gz /tmp/
RUN for i in /tmp/*.tar.gz; do pip install $i && rm $i; done

## move to jovyan user
USER jovyan
WORKDIR /home/jovyan

RUN mkdir -p /home/jovyan/gup/mygup /home/jovyan/gup/results

# Install DIRAC
RUN mamba install -y dirac-grid

# ENTRYPOINT ["/usr/bin/bash"]
#ENTRYPOINT ["/usr/bin/rtg -o"]
#ENTRYPOINT ["/usr/bin/python3"]
