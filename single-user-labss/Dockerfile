FROM eginotebooks/single-user

USER root
RUN apt-get update \
    && apt-get install -y \
        openssh-server expect ftp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID
