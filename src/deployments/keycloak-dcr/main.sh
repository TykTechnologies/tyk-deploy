crName="tyk-dcr";

logger "$INFO" "installing keycloak DCR realm in $namespace namespace...";

sed "s/replace_cr_name/$crName/g" src/deployments/keycloak-dcr/realm-template.yaml | \
sed "s/replace_keycloak/$keycloakName/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$DEBUG" "keycloak-dcr: waiting for $crName to be created";
waitForPods "job-name=$crName" "$crName";
kubectl wait --namespace "$namespace" jobs "$crName" --for=condition=complete --timeout=120s > /dev/null;
kubectl delete --namespace "$namespace" jobs "$crName" > /dev/null;

logger "$INFO" "waiting for keycloak to be ready...";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=delete --timeout=60s > /dev/null;
waitForPods "statefulset.kubernetes.io/pod-name=$keycloakName-0" "$keycloakName-0";
kubectl wait pods --namespace "$namespace" -l "statefulset.kubernetes.io/pod-name=$keycloakName-0" --for=condition=Ready --timeout=180s > /dev/null;
