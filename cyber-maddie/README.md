# Cyber Maddie App

[cyber-maddie.nibir.xyz](http://cyber-maddie.nibir.xyz/)

Source code is on github repository [cyber-maddie](https://github.com/nbir/cyber-maddie) (private).

## Instructions

1. Follow instruction on [cyber-maddie/README.md](https://github.com/nbir/cyber-maddie/blob/main/README.md) to build Docker image locally and push to registry.

2. Install the `cyber-maddie` static website by applying manifest:
    ```
    kubectl apply -f manifests
    ```

    This will create the following resources:
    ```
    namespace/cyber-maddie
    deployment.apps/cyber-maddie
    service/cyber-maddie
    ingress.networking.k8s.io/cyber-maddie-nibir-xyz
    ```

3. To pull the latest docker image, perform a rollout restart (`imagePullPolicy: Always` is set). 
    ```
    kubectl rollout restart deployment cyber-maddie
    ```
