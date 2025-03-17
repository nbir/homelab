# Hardware

- Raspberry Pi Zero W (x1)
- Raspberry Pi 4 Model B 4GB (x5)
- NVIDIA Jetson Nano Developer Kit
- Google WiFi system
- Netgear unmanaged switch (x2)

## DHCP IP Reservation

Fixed IPs reserved for bastion server:

```
192.168.86.101                              # nb-rpi-00 (bastion)
```

Fixed IPs reserved for Kubernetes master & worker nodes:

```
192.168.86.111                              # nb-rpi-01 (k3s master)
192.168.86.112                              # nb-rpi-02
192.168.86.113                              # nb-rpi-03
192.168.86.114                              # nb-rpi-04
192.168.86.115                              # nb-rpi-05
...
```

Fixed IPs reserved for GPU Kubernetes worker node (NVIDIA Jetson Nano):

```
192.168.86.30                               # nb-njn-01
```

## Port Forwarding

Ports forwarded from the router, can be accessed using URL `<PUBLIC_IP_ADDRESS>:<PORT>`.

1. SSH into bastion server.
```
"22     -> 192.168.86.101:22 (TCP)          # nb-rpi-00 (bastion)
```

2. Kubernetes API Server on master node.

```
:6443   -> 192.168.86.111:6443 (TCP/UDP)    # nb-rpi-01 (k3s master)
```

3. Ingress controller on Kubernetes a pinned node.

```
:80     -> 192.168.86.114:80 (TCP)          # nb-rpi-04
:443    -> 192.168.86.114:443 (TCP)         # nb-rpi-04
```