# Cloudflare Tunnel

## Instructions

1. Create a tunnel following instruction on [Use cloudflared to expose a Kubernetes app to the Internet] (https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel/).

2. Create a new namespace `cloudflare-tunnel` by running `kubectl create namespace cloudflare-tunnel`. Apply all resources in this namespace.

3. Use the following command to create the tunnel credentials secret.
    ```
    kubectl create secret generic nb-k8s-347-01-tunnel-credentials \
    --from-file=credentials.json=/Users/nibir/.cloudflared/<tunnel-id>.json
    ```

4. For step _Deploy cloudflared_, apply commited manifests instead by running `kubectl apply -f manifests` (adapted from [cloudflared.yaml](https://raw.githubusercontent.com/cloudflare/argo-tunnel-examples/refs/heads/master/named-tunnel-k8s/cloudflared.yaml)). This will create the following resources:
    ```
    configmap/cloudflared
    deployment.apps/cloudflared
    ```

5. Expose an endpoint by creating an `Ingress` resource (see [ingress-nginx/README.md](/ingress-nginx/README.md)).

6. Turn on __Always Use HTTPS__ on Cloudflare dashboard under SSL/TLS > Edge Certificates.

### Verify

1. Apply manifests in directory [/manifests-verify](./manifests-verify/) by running `kubectl apply -f manifests-verify`. This will create the following resources:
    ```
    namespace/kube-verify
    deployment.apps/demo
    service/demo
    ingress.networking.k8s.io/demo-localhost
    ```

2. Wait until an IP Address is assigned to the `ingress.networking.k8s.io/demo-localhost` object.

3. Curl https://demo.nibir.xyz. This should return **It Works**.

4. Cleanup the verify resources by running `kubectl delete -f manifests-verify`.

### Troubleshooting

1. Set container `cloudflared` image to `cloudflare/cloudflared:latest` (instead of pinned version) if pods are in CrashLoopBackOff. Pod error would show something like:
    ```
    exec /usr/local/bin/cloudflared: exec format error
    ```

## References

- https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel/
- [From Zero to Hero: K3s, Traefik & Cloudflare Your Home Lab Powerhouse](https://youtu.be/drmZjI6JWs8)
