FROM openjdk:8

RUN apt-get update \
    && apt-get install -y libfuse2 fuse \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://data.d4science.org/shub/E_eTB4a3hhZ1ZBbHEweFdPN3FtQXFraW1kQy8zb0FxTkMwSHhEVG1TcVVtWGJnRjJKdWh3aXBWYWxwUmRVQlNjdA== > \
 /sh-fuse-integration-jar-with-dependencies.jar

COPY mount.sh /mount.sh

RUN useradd -u 1000 -g 100 jovyan

USER jovyan

CMD ["/mount.sh"]

