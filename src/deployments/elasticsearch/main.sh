logger "$INFO" "installing elasticsearch in $namespace namespace...";

addService "$elasticsearchReleaseName";

setVerbose;
helm upgrade "$elasticsearchReleaseName" bitnami/elasticsearch \
  --install \
  --set "global.elasticsearch.service.ports.restAPI=$ELASTICSEARCH_SERVICE_PORT" \
  --namespace "$namespace" \
  --wait > /dev/null;
unsetVerbose;
