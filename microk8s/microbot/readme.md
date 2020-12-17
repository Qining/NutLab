Microbot is a custom build of microbot (docker pull dontrebootme/microbot:v1)

Note that this is based on v1 only. V2, v3, latest might not work.

Used to test a K8s cluster.

To build the image and label it so it can be pushed to private local Docker registry:

(Assume the private local docker registry is created by `microk8s enable registry`)

```
docker build . -t localhost:32000/microbot:local
```

To push an image to the private local Docker regitry:

```
docker push localhost:32000/microbot:local
```
