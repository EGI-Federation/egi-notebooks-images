ARG BASE_IMAGE=fake:latest
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
       fuse \
       libfuse2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

ARG FUSE_JAR=https://nexus.d4science.org/nexus/content/repositories/gcube-snapshots/org/gcube/data-access/sh-fuse-integration/1.2.0-SNAPSHOT/sh-fuse-integration-1.2.0-20210708.160531-5-jar-with-dependencies.jar
RUN mamba create -n java8 -q -y openjdk=8 \
    && curl "$FUSE_JAR" > /opt/conda/envs/java8/sh-fuse-integration-jar-with-dependencies.jar \
    && conda clean -tipy
