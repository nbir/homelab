# Vault

## Instructions

1. Add the Hashicorp Vault Helm repository, and search for the latest version of the `vault` chart.
    ```
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm repo update
    helm search repo hashicorp/vault
    ```

    Optionally, download the chart to inspect. It contains a `values.yaml` file documenting each configurable variable.
    ```
    helm fetch hashicorp/vault --version 0.30.0 --untar
    ```

2. Create a self-signed certificate and TLS secret. Run cleanup script `sh scripts/certificate_cleanup.sh` if you need to re-install (Note that this will delete Kubernetes secret & CSR).
    ```
    sh scripts/certificate.sh
    ```

5. Install the `vault` chart.
    ```
    helm install vault \
        hashicorp/vault \
        --version 0.30.0 \
        -f values.yaml \
        --create-namespace \
        --namespace vault
    ```

    Apply additional changes to `values.yaml`.
    ```
    helm upgrade vault \
        hashicorp/vault \
        --version 0.30.0 \
        -f values.yaml \
        --namespace vault
    ```

5. Initialize and unseal Vault.
    ```
    sh scripts/unseal.sh
    ```

6. Log into Vault UI using the root token (from previous step).

### Troubleshooting

1. Vault installed with end-to-end TLS enabled will not work correctly with Cloudflare Tunnel since it terminates TLS on Cloudflare edge. To bypass this add `noTLSVerify: true` to [/cloudflare-tunnel/manifests/configmap.yaml](/cloudflare-tunnel/manifests/configmap.yaml).
    ```
    - hostname: "vault.nibir.xyz"
      service: https://ingress-nginx-controller.ingress-nginx.svc.cluster.local:443
      originRequest:
        noTLSVerify: true
    ```
    
    This also ensures that host _vault.nibir.xyz_ redirects to _ingress-nginx-controller_ port 443 (https) while all other hosts redirect to port 80 (http).

    After this change apply the configmap and restart cloudflare-tunnel pods.
    ```
    kubectl apply -f manifests
    kubectl -n cloudflare-tunnel rollout restart deployment cloudflared
    ```

## References

- https://developer.hashicorp.com/vault/docs/platform/k8s/helm
- [Vault on Kubernetes deployment guide](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide)
