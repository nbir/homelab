# See instructions in https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-tls

# Initialize vault-0 with one key share and one key threshold.

echo "Initialize vault-0 with one key share and one key threshold."
kubectl exec -n $VAULT_K8S_NAMESPACE vault-0 -- vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    -format=json > ${WORKDIR}/cluster-keys.json

# Display the unseal key found in cluster-keys.json.

echo "Display the unseal key found in cluster-keys.json."
jq -r ".unseal_keys_b64[]" ${WORKDIR}/cluster-keys.json

# Create a variable named VAULT_UNSEAL_KEY to capture the Vault unseal key.

echo "Create a variable named VAULT_UNSEAL_KEY to capture the Vault unseal key."
VAULT_UNSEAL_KEY=$(jq -r ".unseal_keys_b64[]" ${WORKDIR}/cluster-keys.json)

# Unseal Vault running on the vault-0 pod.

echo "Unseal Vault running on the vault-0 pod."
kubectl exec -n $VAULT_K8S_NAMESPACE vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY

# Print the HA status

echo "Print the HA status"
kubectl exec -n $VAULT_K8S_NAMESPACE vault-0 -- vault status

# Print the cluster root token
export CLUSTER_ROOT_TOKEN=$(cat ${WORKDIR}/cluster-keys.json | jq -r ".root_token")
echo $CLUSTER_ROOT_TOKEN
