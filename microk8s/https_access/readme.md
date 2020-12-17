An example of allowing HTTPS access to a MicroK8s cluster

0. Make sure HTTP access is working first

1. Define a new namespace 'cert-manager' `kubectl create namespace cert-manager`

New resource types, deployments will be created under that namespace

2. Install cert-manager and related resource types (cert issuer, etc)

```
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.12.0/cert-manager.yaml
```

(Or use the cert-manager.yaml in this dir)

Pods should be created, wait until all pods are ready:

```
kubectl get pods --namespace cert-manager

# wait until output is like:
# NAME                                       READY   STATUS    RESTARTS   AGE
# cert-manager-5c47f46f57-jknnx              1/1     Running   0          27s
# cert-manager-cainjector-6659d6844d-j8cbg   1/1     Running   0          27s
# cert-manager-webhook-547567b88f-qks44      1/1     Running   0          27s
```

3. Create Letsencrypt Cert Issuer (staging) by applying staging_issuer.yaml

4. Apply the `microbot.yaml` and use `kubectl describe certificate`, the state
should be 'ready' after several seconds

`kubectl get secrete` should return `example-tls` as a 'secret'.

`kubectl get certificate` should return `example-tls` as a 'certificate'.

NOTE: if testing on GCE VM, make sure the VM HTTP and HTTPS access is allowed
in the firewall setting. Otherwise chanllenge will fail.

5. If staging works, switch to prod_issuer.yaml, and update the microbot.yaml
to use the **prod** cluster issuer.
