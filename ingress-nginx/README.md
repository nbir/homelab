# Ingress NGINX Controller

## Instructions

Install Ingress NGINX by applying manifest:

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/baremetal/deploy.yaml
```

This will create the following resources:

```
namespace/ingress-nginx

serviceaccount/ingress-nginx
serviceaccount/ingress-nginx-admission

role.rbac.authorization.k8s.io/ingress-nginx
role.rbac.authorization.k8s.io/ingress-nginx-admission

clusterrole.rbac.authorization.k8s.io/ingress-nginx
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission

rolebinding.rbac.authorization.k8s.io/ingress-nginx
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission

clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission

configmap/ingress-nginx-controller

service/ingress-nginx-controller
service/ingress-nginx-controller-admission

deployment.apps/ingress-nginx-controller

job.batch/ingress-nginx-admission-create
job.batch/ingress-nginx-admission-patch

ingressclass.networking.k8s.io/nginx

validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission
```

### Verify

Follow steps in [Local testing](https://kubernetes.github.io/ingress-nginx/deploy/#local-testing) to verify.

### Troubleshooting

1. Disable K3s' built-in Traefik ingress controller in order to run Ingress NGINX Controller. Do so by appending `--disable traefik` to the K3s systemd unit in `/etc/systemd/system/k3s.service`, then run:

```
systemctl daemon-reload && systemctl restart k3s
```

2. [Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/), not [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/).

3. Change `.spec.type` for service `ingress-nginx-controller` from `NodePort` (default) to `LoadBalancer`. Edit by running command:

```
kubectl edit service ingress-nginx-controller --namespace=ingress-nginx
```

## Create An `Ingress` Resource

To create an ingress resource to point to a service run the following command. Use `nibir.xyz` for all external subdomains.

```
kubectl create ingress <ingress-resource-name> --class=nginx \
  --rule="<subdomain>.<domain>/*=<service-resource-name>:<port>"
```

## References

- https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
- [Installing the Nginx Ingress Controller on K3S](https://medium.com/@alesson.viana/installing-the-nginx-ingress-controller-on-k3s-df2c68cae3c8)
- [K3S with metallb and nginx-ingress](https://avi.st/k3s-with-metallb-and-nginx-ingress/)
