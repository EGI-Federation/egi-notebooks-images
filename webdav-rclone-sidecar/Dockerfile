FROM alpine:3.19

ENV MOUNT_PATH=/mnt
ENV WEBDAV_URL=
ENV WEBDAV_VENDOR=other
ENV JOVYAN_UID=1000
ENV JOVYAN_GRP=100

RUN apk --no-cache add bash ca-certificates fuse3 rclone tini \
 && rclone config touch

# to support unprivileged mounts
RUN sed -ie 's/#\s*\(user_allow_other\)/\1/' /etc/fuse.conf

RUN adduser -u $JOVYAN_UID -g $JOVYAN_GRP -D jovyan

USER jovyan
RUN rclone config touch
USER ''

COPY mount.sh /usr/local/bin/

ENTRYPOINT [ "tini", "-g", "--", "mount.sh" ]
