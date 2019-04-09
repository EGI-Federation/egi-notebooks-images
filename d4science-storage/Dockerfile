FROM openjdk:8

RUN apt-get update \
    && apt-get install -y libfuse2 fuse \
    && rm -rf /var/lib/apt/lists/*

RUN curl http://maven.research-infrastructures.eu/nexus/service/local/repositories/gcube-snapshots/content/org/gcube/data-access/sh-fuse-integration/1.0.0-SNAPSHOT/sh-fuse-integration-1.0.0-20190312.161452-1-jar-with-dependencies.jar > /sh-fuse-integration-1.0.0-20190312.161452-1-jar-with-dependencies.jar

COPY mount.sh /mount.sh

RUN useradd -u 1000 -g 100 jovyan

USER jovyan

CMD ["/mount.sh"]

