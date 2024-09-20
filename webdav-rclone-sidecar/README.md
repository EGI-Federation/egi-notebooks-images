# WebDAV Sidecar Image

WebDAV sidecar image using rclone.

## Usage

Using environment:

* WEBDAV\_URL: WebDAV endpoint
* WEBDAV\_USER: WebDAV user
* WEBDAV\_PWD: WebDAV password
* WEBDAV\_TOKEN: WebDAV OIDC token
* WEBDAV\_VENDOR: WebDAV vendor (default: *other*)
* REMOTE\_PATH: remote mount path on webdav backend (default: */*) 
* MOUNT\_OPTS: space separated additional arguments for *rclone mount* command
* MOUNT\_PATH: mount path (default: */mnt*)
* MOUNT\_WAIT: wait time for mountpoint in /proc/mounts (default: *20*)
* MOUNT\_WAIT\_POINT: mountpoint regular expression to wait for (default: (empty))
* VFS\_CACHE\_MODE: value for rclone VFS cache mode (off, minimal, writes, full) (default: *full*)

Examples:

    docker run --privileged -it --rm --name oidcmount -v /tmp/webdav:/mnt:shared \
      -e WEBDAV_URL="$WEBDAV_URL" \
      -e WEBDAV_TOKEN="$(oidc-token my-issuer)" \
      webdav-rclone-sidecar" &

    echo "$(oidc-token my-issuer)" >/tmp/token
    docker run --privileged -it --rm --name oidcmount -v /tmp/webdav:/mnt:shared -v /tmp/token:/tmp/token \
      -e MOUNT_PATH="/mnt/subpath" \
      -e MOUNT_WAIT_POINT="webdav-fs: /mnt fuse.rclone " \
      -e WEBDAV_URL="$WEBDAV_URL" \
      webdav-rclone-sidecar bearer_token_command="cat /tmp/token" &
