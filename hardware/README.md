# Hardware

- Raspberry Pi Zero W (x1)
- Raspberry Pi 4 Model B 4GB (x5)
- NVIDIA Jetson Nano Developer Kit (x1)
- NVIDIA Jetson Orin Nano Developer Kit (x1)
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
192.168.86.114                              # nb-rpi-04 (NFS)
192.168.86.115                              # nb-rpi-05
...
```

Fixed IPs reserved for GPU Kubernetes worker node (NVIDIA Jetson Nano):
```
192.168.86.131                               # nb-njn-01
192.168.86.132                               # nb-njn-02 (orin)
```

## Port Forwarding

Ports forwarded from the router, can be accessed using URL `<PUBLIC_IP_ADDRESS>:<PORT>`.

SSH into bastion server.
```
:22     -> 192.168.86.101:22 (TCP)          # nb-rpi-00 (bastion)
```

Kubernetes API Server on master node.
```
:6443   -> 192.168.86.111:6443 (TCP/UDP)    # nb-rpi-01 (k3s master)
```

OpenMediaVault UI.
```
:11480  -> 192.168.86.114:80 (TCP/UDP)      # nb-rpi-04
```

## Instructions

1. Use [guide](https://www.jetson-ai-lab.com/initial_setup_jon.html) to upgrade firmware on NVIDIA Jetson Orin Nano Developer Kit.
