# Seafile by Docker Compose

## Works with Nginx Proxy

The file *seafile.nginx.conf.template* in the seafile folder is supposed to
overwrite the default *seafile.nginx.conf.template* to support the Seafile
service run behind another Nginx reverse proxy which runs in another container.

There is still one extra step to make uploading/sync working:

In the **System Admin** -> **Settings** page, we need to change the scheme of
`FILE_SERVER_ROOT` from **http** to **https**.
* Otherwise 'File upload' won't work.

Also the `SERVICE_URL` must be changed from the internal **http** url
(the one with port number) to the public facing **https** url and drop the port.
* Otherwise OnlyOffice won't be able to save documents
