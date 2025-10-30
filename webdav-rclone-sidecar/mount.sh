#! /usr/bin/env bash

# Needs to be run as root!

MOUNT_OPTS=${MOUNT_OPTS:-}
# backend remote path mount
REMOTE_PATH=${REMOTE_PATH:-/}
# where to mount
MOUNT_PATH=${MOUNT_PATH:-/mnt/}
MOUNT_WAIT=${MOUNT_WAIT:-20}
JOVYAN_UID=${JOVYAN_UID:-1000}
JOVYAN_GRP=${JOVYAN_GRP:-100}
VFS_CACHE_MODE=${VFS_CACHE_MODE:-full}
# retry loop params
RETRY_ATTEMPTS=${RETRY_ATTEMPTS:-5}
RETRY_DELAY=${RETRY_DELAY:-5}

if [ -n "$MOUNT_WAIT_POINT" ]; then
	i=0
	echo "Checking $MOUNT_WAIT_POINT ($MOUNT_PATH)..."
	while ! grep "^$MOUNT_WAIT_POINT" /proc/mounts && test $i -lt $((2 * MOUNT_WAIT)); do
		echo "Waiting for $MOUNT_WAIT_POINT..."
		sleep 0.5
		i=$((i + 1))
	done
fi

if [ ! -d "$MOUNT_PATH" ]; then
	mkdir -p "$MOUNT_PATH"
	chown "$JOVYAN_UID:$JOVYAN_GRP" "$MOUNT_PATH"
fi

# wait to be killed
do_umount() {
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
IFS=" " read -r -a mount_opts <<<"$MOUNT_OPTS"
mount_opts+=("--vfs-cache-mode=$VFS_CACHE_MODE")

#If connection terminates, try to reconnect, 
retry=0
while test $retry -lt $RETRY_ATTEMPTS; do 
	rclone mount webdav-fs:"$REMOTE_PATH" "$MOUNT_PATH" --allow-non-empty --allow-other --uid="$JOVYAN_UID" --gid="$JOVYAN_GRP" "${mount_opts[@]}"
	if (( $? == 0 )); then
		retry=0
	else
		((retry++))
	fi
	sleep $RETRY_DELAY
done