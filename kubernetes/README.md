# Kubernetes

A Kubernetes cluster running [k3s](https://k3s.io/) on Raspberry Pi master & worker nodes.

## Instructions

### Set up Kubernetes (K3s) on Raspberry Pi

1. Flash headless Debian image _Raspberry Pi OS Lite_ using Raspberry Pi Imager. Edit settings to set a unique hostname and Enable SSH > Allow public-key authentication only.

2. Assign static IP addresses by either configuring the DHCP settings on your router or by editing the network interface file on each host.

3. Enable `cgroups` on each host by appending `cgroup_memory=1 cgroup_enable=memory` to `/boot/firmware/cmdline.txt`.

4. Install **k3s** on the master node by running `sudo curl -sfL https://get.k3s.io | sh -`.

5. Install **k3s** on each worker node by running `sudo curl -sfL https://get.k3s.io | K3S_URL=https://<master_node_ip>:6443 K3S_TOKEN=<token> sh -`. Get the server token from `/var/lib/rancher/k3s/server/token`

### Expose Homelab Cluster to Public Internet

1. Determine public IP address by running `curl ifconfig.co`. Alternatively, you can get this from our router's WAN IP.

2. Add the public IP address as a Subject Alternative Name on the TLS cert by appending the following configuration to `/etc/rancher/k3s/config.yaml`:

```
tls-san: 
  - <public-ip-address>
```

3. Re-sign the TLS cert for the public IP by deleting the current cert & restarting **k3s**.

```
kubectl -n kube-system delete secrets/k3s-serving
rm /var/lib/rancher/k3s/server/tls/dynamic-cert.json

systemctl restart k3s
```

4. Port forward `:6443` (default kubernetes API port) to the master node's IP address.

5. Copy the kube context from the master node onto the remote machine. Get the full context by running `kubectl config view --raw`. Replace `cluster.server` to the public IP address.


## References

- [Step-by-Step Guide: Creating a Kubernetes Cluster on Raspberry Pi 5 with K3s
](https://everythingdevops.dev/step-by-step-guide-creating-a-kubernetes-cluster-on-raspberry-pi-5-with-k3s/)
- [K3s vs MicroK8s Lightweight Kubernetes Distributions](https://www.wallarm.com/cloud-native-products-101/k3s-vs-microk8s-lightweight-kubernetes-distributions)
