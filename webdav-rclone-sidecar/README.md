# WebDAV Sidecar Image

WebDAV sidecar image using rclone.

## Usage

Using environment:

- `WEBDAV_URL`: WebDAV endpoint
- `WEBDAV_USER`: WebDAV user
- `WEBDAV_PWD`: WebDAV password
- `WEBDAV_TOKEN`: WebDAV OIDC token
- `WEBDAV_VENDOR`: WebDAV vendor (default: _other_)
- `REMOTE_PATH`: remote mount path on webdav backend (default: _/_)
- `MOUNT_OPTS`: space separated additional arguments for _rclone mount_ command
- `MOUNT_PATH`: mount path (default: _/mnt_)
- `MOUNT_WAIT`: wait time for mountpoint in /proc/mounts (default: _20_)
- `MOUNT_WAIT_POINT`: mountpoint regular expression to wait for (default:
  (empty))
- `VFS_CACHE_MODE`: value for rclone VFS cache mode (off, minimal, writes, full)
  (default: _full_)

Examples:

```
docker run --privileged -it --rm --name oidcmount -v /tmp/webdav:/mnt:shared \
  -e WEBDAV_URL="$WEBDAV_URL" \
  -e WEBDAV_TOKEN="$(oidc-token my-issuer)" \
  webdav-rclone-sidecar" &
```

```
echo "$(oidc-token my-issuer)" >/tmp/token
docker run --privileged -it --rm --name oidcmount -v /tmp/webdav:/mnt:shared -v /tmp/token:/tmp/token \
  -e MOUNT_PATH="/mnt/subpath" \
  -e MOUNT_WAIT_POINT="webdav-fs: /mnt fuse.rclone " \
  -e WEBDAV_URL="$WEBDAV_URL" \
  webdav-rclone-sidecar bearer_token_command="cat /tmp/token" &
```
