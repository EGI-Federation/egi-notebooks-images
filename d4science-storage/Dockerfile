FROM eclipse-temurin:17

RUN apt-get update \
    && apt-get install -y --no-install-recommends libfuse2 fuse \
    && rm -rf /var/lib/apt/lists/*

ARG FUSE_JAR=https://maven.d4science.org/nexus/content/repositories/gcube-staging-jenkins/org/gcube/data-access/sh-fuse-integration/2.1.0/sh-fuse-integration-2.1.0-jar-with-dependencies.jar

RUN curl $FUSE_JAR > /sh-fuse-integration-jar-with-dependencies.jar

COPY mount.sh /mount.sh

RUN groupadd -o -g 100 jovyan \
    useradd -o -u 1000 -g 100 jovyan

USER jovyan

CMD ["/mount.sh"]
