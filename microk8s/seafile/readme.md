# An example of deploying Seafile on a MicroK8s cluster

This is a bare minimal deployment. The cluster conatins only one replica of all
the Seafile related components, and uses physical nodss storage.

Prerequesite: HTTPS access to the cluster.

* Dockerfile

    Pull the Seafile docker image and overwrite the Nginx config template.
    The Seafile docker registry might return permission error, switch to use
    community version should fix it.

* db.yaml

    Create the deployment and service for MySQL DB, which is to be used by
    Seafile. Note the password should be updated (or supplied in another
    approach).


* seafile.yaml

    Create the deployment, service and ingress for Seafile. Note the admin
    email, password and host name is provided here. The Seafile's built in
    LetsEncrypt support is *disabled*. The SEAFILE_SERVER_HOSTNAME and the
    hosts in the Ingress should match.
