# MinIO

## Instructions

Using MinIO community Helm chart. Not MinIO Operator & MinIO Tenant Helm charts.

1. Create a PersistentVolumes by applying manifests. This requires a NFS share created using [openmediavault](../openmediavault/README.md).
    ```
    kubectl apply -f manifests
    ```

    This will create the following resources:
    ```
    namespace/minio
    persistentvolume/minio-pv
    persistentvolumeclaim/minio-pvc
    ```

    Note this PV is using NFS server `192.168.86.114` and share `nb-nas-k8s-01`.

2. Add the MinIO Helm repository, and search for the latest version of the `minio` chart.
    ```
    helm repo add minio https://operator.min.io
    helm repo update
    helm search repo minio/minio
    ```

    Optionally, download the chart to inspect. It contains a `values.yaml` file documenting each configurable variable.
    ```
    helm fetch minio/minio --version 5.4.0 --untar
    ```

3. Install minio using the `minio` chart. Replace password values. Replace `.rootPassword` and `.users[].secretKey` first.
    ```
    helm install minio \
        minio/minio \
        --version 5.4.0 \
        -f values.yaml \
        --create-namespace \
        --namespace minio
    ```

### Create a Bucket

Log into the MinIO Console UI. Click Create Bucket under Buckets. The bucket is browsable under Object Browser.

## References

- [MinIO Community Helm Chart](https://github.com/minio/minio/tree/master/helm/minio)
- [Kubernetes Homelab Series (Part 2): Longhorn + MinIO for Persistent Storage](https://pdelarco.medium.com/kubernetes-homelab-series-part-2-longhorn-minio-for-persistent-storage-7f65e0bfbbb8)
- [Deploy MinIO Operator With Helm](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html) (not used)
- [Deploy a MinIO Tenant with Helm Charts](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-minio-tenant-helm.html) (not used)
- [How to install MinIO in Kubernetes in 15 min](https://dev.to/giveitatry/how-to-install-minio-in-kubernetes-in-15-min-47h9) (not used)
- [MinIO Policy Based Access Management](https://min.io/docs/minio/linux/administration/identity-access-management/policy-based-access-control.html#minio-policy)
