# MetalLB

## Load Balancer IP Assignment

DHCP IP reserved for MetalLB (specified in [manifests/ipaddresspool.yaml](manifests/ipaddresspool.yaml)):

```
192.168.86.151 to 192.168.86.200
```

## Instructions

Install MetalLB by applying manifest:

```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
```

This will create the following resources:

```
namespace/metallb-system

customresourcedefinition.apiextensions.k8s.io/bfdprofiles.metallb.io
customresourcedefinition.apiextensions.k8s.io/bgpadvertisements.metallb.io
customresourcedefinition.apiextensions.k8s.io/bgppeers.metallb.io
customresourcedefinition.apiextensions.k8s.io/communities.metallb.io
customresourcedefinition.apiextensions.k8s.io/ipaddresspools.metallb.io
customresourcedefinition.apiextensions.k8s.io/l2advertisements.metallb.io
customresourcedefinition.apiextensions.k8s.io/servicel2statuses.metallb.io

serviceaccount/controller
serviceaccount/speaker

role.rbac.authorization.k8s.io/controller
role.rbac.authorization.k8s.io/pod-lister

clusterrole.rbac.authorization.k8s.io/metallb-system:controller
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker

rolebinding.rbac.authorization.k8s.io/controller
rolebinding.rbac.authorization.k8s.io/pod-lister

clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker

configmap/metallb-excludel2

secret/metallb-webhook-cert

service/metallb-webhook-service

deployment.apps/controller

daemonset.apps/speaker

validatingwebhookconfiguration.admissionregistration.k8s.io/metallb-webhook-configuration
```

### Verify

The verify steps are adapted from [this](https://opensource.com/article/20/7/homelab-metallb) guide.

1. All manifests are in directory [/manifests-verify](/manifests-verify/). Create resources by running `kubectl apply -f manifests-verify`. This will create the following resources:

```
namespace/kube-verify
deployment.apps/kube-verify
service/kube-verify
```

2. MetalLB will assign an external IP to the LoadBalancer service. To get the external IP address run `kubectl -n kube-verify get services`. The output will look like:

```
NAME          TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
kube-verify   LoadBalancer   10.43.158.26   192.168.86.152   80:32359/TCP   2m53s
```

3. Verify by running `curl http://<external-ip-address>:80` from any of the K3s master or worker nodes.

4. Cleanup the verify resources by running `kubectl delete -f manifests-verify`.

### Troubleshooting

1. Disable K3s' built-in loadbalancer, Klipper, in order to run MetalLB. Do so by appending `--disable servicelb` to the K3s systemd unit in `/etc/systemd/system/k3s.service`, then run:

```
systemctl daemon-reload && systemctl restart k3s
```


## References

- https://opensource.com/article/20/7/homelab-metallb
- https://metallb.io/installation/
- https://metallb.io/configuration/
