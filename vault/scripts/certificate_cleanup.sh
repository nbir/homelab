# Export the working directory location and the naming variables

echo "Export the working directory location and the naming variables"
export VAULT_K8S_NAMESPACE="vault" \
export VAULT_HELM_RELEASE_NAME="vault" \
export VAULT_SERVICE_NAME="vault-internal" \
export K8S_CLUSTER_NAME="cluster.local" \
export WORKDIR=/tmp/vault

# Delete the TLS secret

echo "Delete the TLS secret"
kubectl delete secret vault-tls -n $VAULT_K8S_NAMESPACE \


# Delete the CSR

echo "Delete the CSR"
kubectl delete certificatesigningrequests.certificates.k8s.io vault.svc

# Delete the working directory

echo "Delete the working directory"
rm -rf /tmp/vault
