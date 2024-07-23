portalDBName=portal;
portalDBPort=54321;
source src/main/storage/pgsql.sh $portalDBName $portalDBPort;

logger "$INFO" "installing portal in $namespace namespace...";

addService "dev-portal-svc-$tykReleaseName-tyk-dev-portal";

args=(
  --set "global.components.devPortal=true" \
  --set "tyk-dev-portal.license=$PORTAL_LICENSE" \
  --set "tyk-dev-portal.image.tag=$PORTAL_VERSION" \
  --set "tyk-dev-portal.containerPort=$PORTAL_SERVICE_PORT" \
  --set "tyk-dev-portal.kind=Deployment" \
  --set "tyk-dev-portal.storage.type=db" \
  --set "tyk-dev-portal.database.dialect=postgres" \
  --set "tyk-dev-portal.database.connectionString=host\=tyk-$portalDBName-postgres-postgresql.$namespace.svc port\=$portalDBPort user\=postgres password\=$TYK_PASSWORD database\=$portalDBName sslmode\=disable" \
  "${portalSecurityContextArgs[@]}" \
  "${portalSSLArgs[@]}" \
  "${portalLoadbalancerArgs[@]}" \
  "${portalIngressArgs[@]}" \
);

addDeploymentArgs "${args[@]}";
upgradeTyk;

source "$portalDeploymentPath/bootstrap.sh";
