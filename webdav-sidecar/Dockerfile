FROM alpine:3.14

ENV MOUNT_PATH=/mnt
ENV WEBDAV_URL=
ENV WEBDAV_USER=
ENV WEBDAV_PWD=
# user info
ENV JOVYAN_UID=1000
ENV JOVYAN_GRP=100

# install davfs
RUN apk --no-cache add ca-certificates davfs2 tini

# create jovyan user
RUN adduser -u $JOVYAN_UID -g $JOVYAN_GRP -D jovyan

COPY mount.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/mount.sh

CMD [ "tini", "-g", "--", "mount.sh" ]
