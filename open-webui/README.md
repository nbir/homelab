# Open WebUI

UI for Ollama. Currently configured to used ollama servers running on 2 static hosts:
```
http://192.168.86.131:11434                 # nb-njn-01
http://192.168.86.132:11434                 # nb-njn-02 (orin)
```

## Instructions

1. Add the Open WebUI Helm repository, and search for the latest version of the `open-webui` chart.
    ```
    helm repo add open-webui https://open-webui.github.io/helm-charts
    helm repo update
    helm search repo open-webui/open-webui
    ```

    Optionally, download the chart to inspect. It contains a `values.yaml` file documenting each configurable variable.
    ```
    helm fetch open-webui/open-webui --version 6.4.0 --untar
    ```

2. Install the `open-webui` chart. Replace password values first.
    ```
    helm install open-webui \
        open-webui/open-webui \
        --version 6.4.0 \
        -f values.yaml \
        --create-namespace \
        --namespace open-webui
    ```

    Apply additional changes to `values.yaml`.
    ```
    helm upgrade open-webui \
        open-webui/open-webui \
        --version 6.4.0 \
        -f values.yaml \
        --namespace open-webui
    ```

## References

- https://docs.openwebui.com/getting-started/quick-start/
