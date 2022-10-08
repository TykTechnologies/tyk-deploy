if [[ -z "$PORTAL_LICENSE" ]]; then
  echo "Please make sure the PORTAL_LICENSE variable is set in your .env file"
  exit 0
fi

portalDB=portal
source src/pgsql.sh $portalDB;

set -x
# Hack until code is merged
k create secret -n $namespace generic tyk-enterprise-portal-conf \
  --from-literal "TYK_AUTH=$(k get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_AUTH}' | base64 -d)" \
  --from-literal "TYK_ORG=$(k get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_ORG}' | base64 -d)"

helm upgrade tyk-pro $TYK_HELM_CHART_PATH/tyk-pro \
  -n $namespace \
  "${tykArgs[@]}" \
  "${tykRedisArgs[@]}" \
  "${tykDatabaseArgs[@]}" \
  "${tykSecurityContextArgs[@]}" \
  "${gatewaySecurityContextArgs[@]}" \
  --set "enterprisePortal.license=$PORTAL_LICENSE" \
  --set "enterprisePortal.enabled=true" \
  --set "enterprisePortal.storage.database.connectionString=host\=tyk-$portalDB-postgres-postgresql.$namespace.svc.cluster.local port\=5432 user\=postgres password\=$PASSWORD database\=$portalDB sslmode\=disable" \
  "${potalSecurityContextArgs[@]}" \
  --wait
set +x
