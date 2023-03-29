KIBANA_SERVICE_PORT=5601;
elasticsearchKibanaReleaseName="elasticsearch-kibana";

if [ -z "$elasticsearchKibanaRegistered" ]; then
  elasticsearchKibanaRegistered=true;
  source "src/deployments/elasticsearch/main.safe.sh";
  source "src/deployments/elasticsearch-kibana/openshift.sh";
  source "src/deployments/elasticsearch-kibana/main.sh";
  source "src/deployments/k6-slo-traffic/main.safe.sh";
fi
