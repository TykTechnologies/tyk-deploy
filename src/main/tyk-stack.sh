source src/main/storage/main.sh;

tykReleaseName="tyk-stack";
args=(--set "global.license.dashboard=$LICENSE" \
  --set "tyk-gateway.gateway.service.port=8080" \
  --set "tyk-gateway.gateway.image.tag=$GATEWAY_VERSION" \
  --set "tyk-pump.pump.image.repository=tykio/tyk-pump-docker-pub" \
  --set "tyk-pump.pump.image.tag=$PUMP_VERSION" \
  --set "tyk-dashboard.dashboard.adminUser.email=$USERNAME" \
  --set "tyk-dashboard.dashboard.adminUser.password=$PASSWORD" \
  --set "tyk-dashboard.dashboard.image.tag=$DASHBOARD_VERSION" \
  --set "tyk-bootstrap.bootstrap.dashboard.deploymentName=dashboard-$tykReleaseName-tyk-dashboard");

addService "dashboard-svc-$tykReleaseName-tyk-dashboard";
addService "gateway-svc-$tykReleaseName-tyk-gateway";
addServiceArgs "dash";
addServiceArgs "gateway";
checkTykRelease;

addDeploymentArgs "${args[@]}";
addDeploymentArgs "${gatewaySecurityContextArgs[@]}";
addDeploymentArgs "${tykSecurityContextArgs[@]}";
addDeploymentArgs "${servicesArgs[@]}";
addDeploymentArgs "${extraEnvs[@]}";
upgradeTyk;

addSummary "\tTyk Stack deployed\n \
\tDashboard username: $USERNAME\n \
\tDashboard password: $PASSWORD";
