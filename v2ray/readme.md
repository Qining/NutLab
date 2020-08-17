# v2ray

## Steps

* Start nginx server on thefd host `sudo service nginx restart`. Make sure Nginx
  is working properly.
* Modify `sample_site`, `config`, `dot.env` accordingly.
* `docker-compose up -d`
* Check `netstat -tlnp` to make sure both the mock and the v2ray service are
  started
  * `curl http://127.0.0.1:9001/change_path` should result into an error in the
    v2ray error log, saying: 'upgrade' token not found in 'Connection' header
* Put `sample_site` to /etc/nginx/sites-available and create symbolic link to
  it in /etc/nginx/sites-enabled.
* Make sure mock can be accessed with port 80
* `sudo certbot --nginx` to enable HTTPS
* Mock should be accessible with HTTPS. And v2ray should be usable now.
  * The client side:
    * Address: change.domain.me
    * Port: 443
    * AlterId: 0
    * Streaming Protocol: ws
    * Path: /change_path
    * Underlying protocal: tls

## sample_site

* To be put in /etc/nginx/sites-available and linked to /etc/nginx/sites-enabled.
* Need to change the `change_path` and `change.domain.me` accordingly.
* Use `sudo certbot --nginx` to enable HTTPS. Make sure `change.domain.me` has
  has been setup properly before doing this.certbot will rewrite the config in
  /etc/nginx/sites-available.
  * Use `nslookup change.domain.me` to check.

## config.json
* v2ray server side config file
* The `inbound.streamSettings.wsSettings.path` must match with the `change_path`
  in the sample_site, use [random.org](https://random.org/strings) to generate
  the string
* The `UUID` should be obtained from [UUID Generator](https://uuidgenerator.net)
  The `UUID` will be used to for client to connect to the server

