customMetrics="[{\"name\": \"tyk_http_requests_total\"\,\"description\": \"Total of API requests\"\,\"metric_type\": \"counter\"\,\"labels\": [\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}\,{\"name\": \"tyk_http_latency\"\,\"description\": \"Latency of API requests\"\,\"metric_type\": \"histogram\"\,\"labels\": [\"type\"\,\"response_code\"\,\"api_name\"\,\"method\"\,\"api_key\"\,\"alias\"\,\"path\"]}]"

args=(
  --set "global.components.pump=true" \
  --set "tyk-pump.pump.service.enabled=true" \
  --set "tyk-pump.pump.service.port=$PROMETHEUS_PUMP_PORT" \
  --set "tyk-pump.pump.containerPort=$PROMETHEUS_PUMP_PORT" \
  --set "tyk-pump.pump.backend[$pumpBackendsCtr]=prometheus" \
  --set "tyk-pump.pump.prometheusPump.host=0.0.0.0" \
  --set "tyk-pump.pump.prometheusPump.path=$PROMETHEUS_PUMP_PATH" \
  --set "tyk-pump.pump.prometheusPump.customMetrics=$customMetrics" \
);

pumpBackendsCtr=$((pumpBackendsCtr + 1));

addService "pump-svc-$tykReleaseName-tyk-pump";
addDeploymentArgs "${args[@]}";
