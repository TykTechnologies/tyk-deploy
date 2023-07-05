source src/main/namespace.sh;
source src/main/redis/main.sh;

cluster=$(kubectl config current-context);

args=(--set "global.remoteControlPlane.connectionString=$TYK_WORKER_CONNECTIONSTRING" \
  --set "global.remoteControlPlane.orgId=$TYK_WORKER_ORGID" \
  --set "global.remoteControlPlane.userApiKey=$TYK_WORKER_AUTHTOKEN" \
  --set "global.remoteControlPlane.useSSL=$TYK_WORKER_USESSL" \
  --set "global.remoteControlPlane.groupId=$(echo "$cluster/$namespace" | base64)" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-gateway.gateway.sharding.enabled=$TYK_WORKER_SHARDING_ENABLED" \
  --set "tyk-gateway.gateway.sharding.tags=$TYK_WORKER_SHARDING_TAGS" \
  --set "tyk-gateway.gateway.service.port=$TYK_WORKER_GW_PORT");

if [ -z "$TYK_WORKER_SHARDING_TAGS" ]
then
      tykReleaseName="tyk-dp-tyk-hybrid";
else
      tykReleaseName="tyk-dp-tyk-hybrid-$TYK_WORKER_SHARDING_TAGS";
fi
logger "$DEBUG" "tykReleaseName=$tykReleaseName";

addService "gateway-svc-$tykReleaseName";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;
if [[ -n "$TYK_WORKER_OPERATOR_CONNECTIONSTRING" ]]; then
  logger "$INFO" "creating tyk-operator secret...";
  kubectl create secret generic tyk-operator-conf \
    --from-literal="TYK_MODE=pro" \
    --from-literal="TYK_URL=$TYK_WORKER_OPERATOR_CONNECTIONSTRING" \
    --from-literal="TYK_AUTH=$TYK_WORKER_AUTHTOKEN" \
    --from-literal="TYK_ORG=$TYK_WORKER_ORGID" \
    --dry-run=client -o=yaml | \
    kubectl apply --namespace "$namespace" -f - > /dev/null;
fi

addSummary "\tTyk Worker Gateway deployed\n
\tMDCB Connection: $TYK_WORKER_CONNECTIONSTRING";
