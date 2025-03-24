# Longhorn

## Instructions

1. Install the following prerequisite packages.
```
apt-get install open-iscsi
apt-get install cryptsetup
apt-get install dmsetup
```

2. Install Longhorn by applying manifest:
```
kubectl apply -f manifests/longhorn.yaml
```

or 

```
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.8.1/deploy/longhorn.yaml
```

This will create the following resources:
```
namespace/longhorn-system

priorityclass.scheduling.k8s.io/longhorn-critical

serviceaccount/longhorn-service-account
serviceaccount/longhorn-ui-service-account
serviceaccount/longhorn-support-bundle

configmap/longhorn-default-resource
configmap/longhorn-default-setting
configmap/longhorn-storageclass

customresourcedefinition.apiextensions.k8s.io/backingimagedatasources.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backingimagemanagers.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backingimages.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backupbackingimages.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backups.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backuptargets.longhorn.io
customresourcedefinition.apiextensions.k8s.io/backupvolumes.longhorn.io
customresourcedefinition.apiextensions.k8s.io/engineimages.longhorn.io
customresourcedefinition.apiextensions.k8s.io/engines.longhorn.io
customresourcedefinition.apiextensions.k8s.io/instancemanagers.longhorn.io
customresourcedefinition.apiextensions.k8s.io/nodes.longhorn.io
customresourcedefinition.apiextensions.k8s.io/orphans.longhorn.io
customresourcedefinition.apiextensions.k8s.io/recurringjobs.longhorn.io
customresourcedefinition.apiextensions.k8s.io/replicas.longhorn.io
customresourcedefinition.apiextensions.k8s.io/settings.longhorn.io
customresourcedefinition.apiextensions.k8s.io/sharemanagers.longhorn.io
customresourcedefinition.apiextensions.k8s.io/snapshots.longhorn.io
customresourcedefinition.apiextensions.k8s.io/supportbundles.longhorn.io
customresourcedefinition.apiextensions.k8s.io/systembackups.longhorn.io
customresourcedefinition.apiextensions.k8s.io/systemrestores.longhorn.io
customresourcedefinition.apiextensions.k8s.io/volumeattachments.longhorn.io
customresourcedefinition.apiextensions.k8s.io/volumes.longhorn.io

clusterrole.rbac.authorization.k8s.io/longhorn-role

clusterrolebinding.rbac.authorization.k8s.io/longhorn-bind
clusterrolebinding.rbac.authorization.k8s.io/longhorn-support-bundle

service/longhorn-backend
service/longhorn-frontend
service/longhorn-conversion-webhook
service/longhorn-admission-webhook
service/longhorn-recovery-backend

daemonset.apps/longhorn-manager

deployment.apps/longhorn-driver-deployer
deployment.apps/longhorn-ui
```

3. Create a secret from local `auth` following instructions [here](https://longhorn.io/docs/1.8.1/deploy/accessing-the-ui/longhorn-ingress/).
```
kubectl create secret generic basic-auth --from-file=auth
```

This will create the following resources:
```
secret/basic-auth
```

4. Create ingress by applying manifest:
```
kubectl apply -f manifests/longhorn-ingress.yaml
```

This will create the following resources:
```
ingress.networking.k8s.io/longhorn-ingress
```

## References

- https://longhorn.io/docs/1.8.1/deploy/install/
- https://longhorn.io/docs/1.8.1/deploy/install/install-with-kubectl/
- https://longhorn.io/docs/1.8.1/deploy/accessing-the-ui/longhorn-ingress/
- [Kubernetes Homelab Series (Part 2): Longhorn + MinIO for Persistent Storage](https://pdelarco.medium.com/kubernetes-homelab-series-part-2-longhorn-minio-for-persistent-storage-7f65e0bfbbb8)
