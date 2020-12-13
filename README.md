# Summary

This repository holds my K8s development setup. 

- NFS dynamic provisioner
- Promtail / Loki / Grafana (PLG) stack
- Prometheus
  - Prometheus operator
  - Thanos
- Postgres
- Kafka
- Chaos Engineering


# Getting Started

## Set up n-node K8s cluster

```Bash
kind create cluster --config kind\config.yaml
k cluster-info --context kind-kind
```

## NFS
```Bash
vagrant up
vagrant ssh nfs-server
```




## Setup Promtail, Loki, Grafana monitoring stack via helm
```Bash
helm upgrade --install loki loki/loki -f helm\loki_values.yaml -n monitoring
helm upgrade --install promtail loki/promtail -f helm\promtail_values.yaml -n monitoring
helm upgrade --install grafana grafana/grafana -f helm\grafana_values.yaml -n monitoring
```  
- should move these resources outside of cluster for monitoring cluster failure


## Prometheus Setup
```Bash
k create configmap prometheus-config —-from-file prometheus.yml -n monitoring
k create configmap prometheus-config --from-file prometheus.yml -o yaml --dry-run | k replace -f -
```

#### Additional Notes

Deprecated:

## Setup nfs
Start nfs docker container mounted to host directory
```Bash
docker run --network=minikube -itd --privileged --restart unless-stopped -e SHARED_DIRECTORY=/data -v //d/data/nfs-storage:/data -p 2049:2049 itsthenetwork/nfs-server-alpine:12
```
From K8s worker nodes (client), mount NFS
```Bash
mount -t nfs 172.18.0.3:/ /mnt
```