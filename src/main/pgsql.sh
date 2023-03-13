postgresReleaseName="tyk-$1-postgres";
checkHelmReleaseExists "$postgresReleaseName";

if $releaseExists; then
  logger "$INFO" "$postgresReleaseName release already exists in $namespace namespace...";
else
  logger "$INFO" "installing $postgresReleaseName in namespace $namespace";
fi

setVerbose;
helm upgrade "$postgresReleaseName" bitnami/postgresql --version 11.9.7 \
  --install \
  --namespace "$namespace" \
  --set "image.repository=zalbiraw/postgresql" \
  --set "image.tag=12.12.0-debian-11" \
  \
  --set "volumePermissions.image.repository=zalbiraw/bitnami-shell" \
  --set "volumePermissions.image.tag=11.0.0-debian-11" \
  \
  --set "metrics.image.repository=zalbiraw/postgresql-exporter" \
  --set "metrics.image.tag=0.11.1-debian-11" \
  \
  --set "auth.database=$1" \
  --set "auth.postgresPassword=$PASSWORD" \
  --set "containerPorts.postgresql=$2" \
  --set "primary.service.ports.postgresql=$2" \
  "${postgresSecurityContextArgs[@]}" \
  --atomic \
  --wait > /dev/null;
unsetVerbose;
