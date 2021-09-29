#! /usr/bin/env sh

# Needs to be run as root!

# where to mount
MOUNT_PATH=${MOUNT_PATH:-/mnt/}
JOVYAN_UID=${JOVYAN_UID:-1000}
JOVYAN_GRP=${JOVYAN_GRP:-100}

if [ ! -d "$MOUNT_PATH" ]; then
    mkdir -p "$MOUNT_PATH"
    chown "$JOVYAN_UID:$JOVYAN_GRP" "$MOUNT_PATH"
fi

# Configure secrets for the server
echo "$WEBDAV_URL $WEBDAV_USER $WEBDAV_PWD" >> /etc/davfs2/secrets
mount -t davfs "$WEBDAV_URL" "$MOUNT_PATH" -o "uid=$JOVYAN_UID,gid=$JOVYAN_GRP,dir_mode=755,file_mode=755"

# wait to be killed
do_umount () {
    umount -l "$MOUNT_PATH"
    exit $?
}

trap "do_umount" INT
trap "do_umount" TERM 

while [ true ]; do
    sleep 30
done
