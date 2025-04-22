# kube-prometheus-stack

Monitoring stack with Prometheus using the Prometheus Operator, Grafana, Alertmanager, kube-state-metrics, and Node Exporter.

## Instructions

1. Add the Prometheus Community Helm repository, and search for the latest version of the `kube-prometheus-stack` chart.
    ```
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm search repo prometheus-community/kube-prometheus-stack
    ```

    Optionally, download the `kube-prometheus-stack` chart to inspect. It contains a `values.yaml` file documenting each configurable variable.
    ```
    helm fetch prometheus-community/kube-prometheus-stack --untar
    ```

2. Install the `kube-prometheus-stack` chart. Replace `.grafana.adminPassword` first.
    ```
    helm install kube-prometheus-stack \
        prometheus-community/kube-prometheus-stack \
        --version 70.3.0 \
        -f values.yaml \
        --create-namespace \
        --namespace kube-prometheus-stack
    ```

    Note: The `values.yaml` file overrides:
    - Grafana admin password
    - Sets Grafana service type to `LoadBalancer`
    - Enables Grafana ingress resource
    - Uses `longhorn` StorageClass for both Grafana & Prometheus

    Apply additional changes to `values.yaml`.
    ```
    helm upgrade kube-prometheus-stack \
        prometheus-community/kube-prometheus-stack \
        --version 70.3.0 \
        -f values.yaml \
        --namespace kube-prometheus-stack
    ```

3. (Optional) Continue installing Loki for logs as described in [../loki](../loki/README.md).

## References

- [kube-prometheus-stack Helm Chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
- [Kubernetes Homelab Series (Part 3): Monitoring and Observability with Prometheus and Grafana](https://pdelarco.medium.com/kubernetes-homelab-series-part-3-monitoring-and-observability-with-prometheus-and-grafana-cac63802c1f9)
- [Setting Up a Prometheus and Grafana Monitoring Stack from Scratch
](https://medium.com/@platform.engineers/setting-up-a-prometheus-and-grafana-monitoring-stack-from-scratch-63667bf3e011)
- [How to create a Monitoring Stack using Kube-Prometheus-stack (Part 1)](https://medium.com/israeli-tech-radar/how-to-create-a-monitoring-stack-using-kube-prometheus-stack-part-1-eff8bf7ba9a9)
