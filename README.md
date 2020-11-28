# Getting Started

## Set up n-node K8s cluster

```Bash
kind create cluster --config kind\config.yaml

kubectl cluster-info --context kind-kind
```


## Setup nfs
Start nfs docker container mounted to host directory
```Bash
docker run --network=kind -itd --privileged --restart unless-stopped -e SHARED_DIRECTORY=/data -v //d/data/nfs-storage:/data -p 2049:2049 itsthenetwork/nfs-server-alpine:12
```
From K8s worker nodes (client), mount NFS
```Bash
mount -t nfs 172.18.0.5:/ /mnt
```
