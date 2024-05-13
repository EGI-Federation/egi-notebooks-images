#! /usr/bin/env bash

# Needs to be run as root!

MOUNT_OPTS=${MOUNT_OPTS:-}
# where to mount
MOUNT_PATH=${MOUNT_PATH:-/mnt/}
JOVYAN_UID=${JOVYAN_UID:-1000}
JOVYAN_GRP=${JOVYAN_GRP:-100}
VFS_CACHE_MODE=${VFS_CACHE_MODE:-full}

if [ ! -d "$MOUNT_PATH" ]; then
    mkdir -p "$MOUNT_PATH"
    chown "$JOVYAN_UID:$JOVYAN_GRP" "$MOUNT_PATH"
fi

# wait to be killed
do_umount () {
    fusermount3 -u -z "$MOUNT_PATH"
    exit $?
}

trap "do_umount" INT
trap "do_umount" TERM

# Configure rclone client
args+=("url=$WEBDAV_URL")
args+=("vendor=$WEBDAV_VENDOR")
[ -n "$WEBDAV_USER" ] && args+=("user=$WEBDAV_USER")
[ -n "$WEBDAV_PWD" ] && args+=("pass=$WEBDAV_PWD")
[ -n "$WEBDAV_TOKEN" ] && args+=("bearer_token=$WEBDAV_TOKEN")
rclone config create --non-interactive webdav-fs webdav "${args[@]}" "$@"

# Mount
# allow-non-empty: bind mounts
# allow-other: access from other unix accounts
# uid: unix owner
# gid: unix group
# vfs-cache-mode: random access and cache
IFS=" " read -r -a mount_opts <<< "$MOUNT_OPTS"
mount_opts+=("--vfs-cache-mode=$VFS_CACHE_MODE")
rclone mount webdav-fs:/ "$MOUNT_PATH" --allow-non-empty --allow-other --uid="$JOVYAN_UID" --gid="$JOVYAN_GRP" "${mount_opts[@]}"
