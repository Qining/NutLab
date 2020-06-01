# HomeLab

## Seafile

### Works with Nginx Proxy

Seafile docker image contains a nginx proxy, which make is HTTPS capable out of
box. However, this feature actually hurdles when we don't want to use the embeded
reverse proxy. In HomeLab, we are hosting multiple apps behind one Nginx proxy so
that we have to diable the embeded proxy.

Most of the necessary bits to achieve this have been added to the docker compose
file. But there is one thing left. One have to add following lines to the
`/etc/nginx/conf.d/default.conf` (or the config file that contains the
configuration for the Seafile virtual host.
```
# In the 'server {... location {' block, below the existing 'proxy_pass http://xxx' line
# add:
  add_header Real-Server $upstream_addr;
  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $remote_addr;
```
