FROM openjdk:11

RUN apt-get update \
    && apt-get install -y --no-install-recommends libfuse2 fuse tini \
    && rm -rf /var/lib/apt/lists/*

ARG FUSE_JAR=https://nexus.d4science.org/nexus/content/repositories/gcube-snapshots/org/gcube/data-access/sh-fuse-integration/3.0.0-SNAPSHOT/sh-fuse-integration-3.0.0-20241201.110429-3.jar

RUN curl $FUSE_JAR > /sh-fuse-integration-jar-with-dependencies.jar

COPY mount.sh /mount.sh

RUN groupadd -o -g 100 jovyan \
    && useradd -o -u 1000 -g 100 jovyan

RUN mkdir /workspace && chown 1000:100 /workspace

USER 1000

ENTRYPOINT ["tini", "-e", "143", "-e", "137", "--"]
CMD ["/mount.sh"]
