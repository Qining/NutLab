An example of allowing HTTP access to a MicroK8s cluster

1. Apply 'nginx-rbac.yaml'

This is to define namespaces, service account, cluster roles and bind the role
with the service account.

2. Apply 'nginx.yaml'

This is to deploy the 'ingress controller', which is Nginx here. The ingress
controller is added to the cluster as a Deployment. But we specified a label
so that the deployment will only use the node(s) with the specific label.

The ingress controller also needs a 'default' service and the corresponding
'default' deployment to handle the 'unknown host' case.

The ConfigMap is requierd by the Nginx ingress controller

3. Apply 'microbot.yaml'

This deploys the Microbot pods as a deployment, defines a service for the
deployment and defines an ingress for the service, so the service can be
accessed through HTTP. Note the 'annotations' in the 'metadata' fields, that
specifies it should use the ingress controller deployed in step 2.
