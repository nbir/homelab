# Loki

Grafana Loki for logs.

## Instructions

Prerequisite: Install `kube-prometheus-stack` as described in [../kube-prometheus-stack](../kube-prometheus-stack/README.md)

1. Add the Grafana Helm repository, and search for the latest version of the `loki` chart.
    ```
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo update
    helm search repo grafana/loki
    ```

    Optionally, download the chart to inspect. It contains a `values.yaml` file documenting each configurable variable.
    ```
    helm fetch grafana/loki --version 6.29.0 --untar
    ```

2. Create a secret containing the MinIO accessKeyId and secretAccessKey.
    ```
    kubectl create secret generic loki-minio-creds \
        -n loki \
        --from-literal=accessKeyId=<access-key-id> \
        --from-literal=secretAccessKey=<secret-access-key>
    ```

3. Install the `loki` chart. Replace `.loki.storage.s3.secretAccessKey` and `.loki.storage.s3.accessKeyId`
    ```
    helm upgrade --install loki \
        grafana/loki \
        --version 6.29.0 \
        -f values.yaml \
        --create-namespace \
        --namespace loki
    ```

    Apply additional changes to `values.yaml`.
    ```
    helm upgrade loki \
        grafana/loki \
        --version 6.29.0 \
        -f values.yaml \
        --namespace loki
    ```

### Troubleshooting

1. Check Compactor logs if nothing is stored in the MinIO bucket.
    ```
    kubectl logs -n loki -l app.kubernetes.io/component=compactor -f
    ```

## References
- [Loki | Install the microservice Helm chart](https://grafana.com/docs/loki/latest/setup/install/helm/install-microservices/)
- [How to create a Monitoring Stack using Kube-Prometheus-stack (Part 1)](https://medium.com/israeli-tech-radar/how-to-create-a-monitoring-stack-using-kube-prometheus-stack-part-1-eff8bf7ba9a9)
- [Store Loki Logs in an S3 Bucket with Kube-Prometheus-Stack](https://techanek.com/how-to-store-loki-logs-in-an-s3-bucket/)
