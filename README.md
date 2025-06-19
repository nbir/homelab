# Homelab

Homelab content.


Infrastucture:

1. [hardware/](/hardware/) - hardware components & network configuration
2. [kubernetes/](/kubernetes/) - kubernetes setup
3. [metallb/](/metallb/) - MetalLB load balancer
4. [ingress-nginx/](/ingress-nginx/) - Ingress NGINX Controller
5. [cloudflare-tunnel/](/cloudflare-tunnel/) - Cloudflare zero trust tunnel
6. [longhorn/](/longhorn/) - distributed block storage for PVs
7. [kube-prometheus-stack/](/kube-prometheus-stack) - Prometheus & Grafana monitoring stack
8. [openmediavault](/openmediavault) - OpemMediaVault for NFS
9. [minio](/minio) - MinIO object storage
10. [loki](/loki/) - Grafana Loki for logs
11. [vault](/vault/) - Vault for secrets

Applications:

1. [beermetwice/](/beermetwice/) - BeerMeTwice, drink counter app
2. [cyber-maddie/](/cyber-maddie/) - Tamagotchi style game
3. [open-webui](/open-webui/) - Open WebUI UI for Ollama
4. [turn-a-day](/turn-a-day/) - Daily productivity journaling app

## How To

1. Remote SSH into bastion server by running `ssh <PUBLIC_IP_ADDRESS>`.
2. To access homelab Kubernetes cluster using `kubectl` see [README](/kubernetes/README.md).
4. Public endpoints are on domain `*.nibir.xyz`.
