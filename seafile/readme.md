# Seafile by Docker Compose

## Modify the built-in Nginx Proxy

The file *seafile.nginx.conf.template* in the seafile folder is supposed to
overwrite the default *seafile.nginx.conf.template* to allow the Seafile
service running behind another Nginx reverse proxy which may run in another
container or in the host.

There is still one extra step to make uploading/sync working:

In the **System Admin** -> **Settings** page, we need to change the scheme of
`FILE_SERVER_ROOT` from **http** to **https**.
* Otherwise 'File upload' won't work.

Also the `SERVICE_URL` must be changed from the internal **http** url
(the one with port number) to the public facing **https** url and drop the port.
* Otherwise OnlyOffice won't be able to save documents


## Modify seahub_settings.py to finish OnlyOffice and thumbnail setup

Add following snippet to the 'conf/seahub_settings.py'

```python
# Thumbnails
ENABLE_THUMBNAIL = True
# video thumbnail is not supported anymore, hope to have this feature again in future
ENABLE_VIDEO_THUMBNAIL = True
THUMBNAIL_VIDEO_FRAME_TIME = 1
THUMBNAIL_SIZE_FOR_ORIGINAL = 1024
THUMBNAIL_ROOT = '/opt/seafile/seahub-data/thumbnail/'

# Enable OnlyOffice
ENABLE_ONLYOFFICE = True
VERIFY_ONLYOFFICE_CERTIFICATE = True
ONLYOFFICE_APIJS_URL = 'https://seafile.example.org/onlyofficeds/web-apps/apps/api/documents/api.js'
ONLYOFFICE_FILE_EXTENSION = ('doc', 'docx', 'ppt', 'xls', 'xlsx', 'odt', 'fodt', 'odp', 'fodp', 'ods', 'fods')
ONLYOFFICE_EDIT_FILE_EXTENSION = ('doc', 'docx', 'ppt', 'xls', 'xlsx', 'odt', 'fodt', 'odp', 'fodp', 'ods', 'fods')
```

## Modify Nginx on host (if not using the provided Nginx image)
Recommend using Certbot to manage the SSL certificates

Check the 'seafile_nginx_sample'

[Link](https://cloud.seafile.com/published/seafile-manual-cn/deploy/https_with_nginx.md)
to example in official document

## Enable Webdav

Enable in 'conf/seafdav.conf', do not enable fastCGI
```
[WEBDAV]
enable = true
port = 8080
fastcgi = false
share_name = /seafdav
```

Add upstream for Webdav and add location and prox_pass
```
# seafdav
upstream seafdav {
  server 192.168.1.221:18080;
  server 127.0.0.1 down;
}

server {
...
location /seafdav {
  proxy_pass http://seafdav/seafdav;
  proxy_set_header Host $http_host;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host $server_name;
  proxy_set_header X-Forwarded-Proto $proxy_x_forwarded_proto;
  proxy_set_header X-Forwarded-Ssl $proxy_x_forwarded_ssl;
  
  proxy_read_timeout 1200s;
  client_max_body_size 0;
  
  access_log  /var/log/nginx/seafdav.access.log;
  error_log   /var/log/nginx/seafdav.error.log;
}
}
```

Use davfs2 (`sudo apt-get install davfs2`) on Linux to mount Webdav

Allowing non-root user to 'mount': might be a good idea for personal use in LAN

```
# First: make sure /path/to/mount/point is an existing empty directory
sudo mount -t davfs -o uid=1000 https://seafile.example.org/seafdav /path/to/mount/point

# umount
sudo umount /path/to/mount/point

# If unmount failed, check the user processes of the mount
lsof | grep '/path/to/mount/point'
```

