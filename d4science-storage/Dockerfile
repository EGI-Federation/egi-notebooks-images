FROM openjdk:8

RUN apt-get update \
    && apt-get install -y libfuse2 fuse \
    && rm -rf /var/lib/apt/lists/*

ARG FUSE_JAR=https://nexus.d4science.org/nexus/content/repositories/gcube-staging-jenkins/org/gcube/data-access/sh-fuse-integration/1.1.1/sh-fuse-integration-1.1.1-jar-with-dependencies.jar

RUN curl $FUSE_JAR > /sh-fuse-integration-jar-with-dependencies.jar

COPY mount.sh /mount.sh

RUN useradd -u 1000 -g 100 jovyan

USER jovyan

CMD ["/mount.sh"]

