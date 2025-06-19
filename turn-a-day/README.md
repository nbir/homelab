# Turn A Day App

[turn-a-day.nibir.xyz](http://turn-a-day.nibir.xyz/)

Source code is on github repository [cyber-maddie](https://github.com/nbir/turn-a-day) (private).

## Instructions

1. Follow instruction on [turn-a-day/README.md](https://github.com/nbir/turn-a-day/blob/main/README.md) to build Docker image locally and push to registry.

2. Install the `turn-a-day` static website by applying manifest:
    ```
    kubectl apply -f manifests
    ```

    This will create the following resources:
    ```
    namespace/turn-a-day
    deployment.apps/turn-a-day
    service/turn-a-day
    ingress.networking.k8s.io/turn-a-day-nibir-xyz
    ```

3. To pull the latest docker image, perform a rollout restart (`imagePullPolicy: Always` is set). 
    ```
    kubectl rollout restart deployment turn-a-day
    ```
