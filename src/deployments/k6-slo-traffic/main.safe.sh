k6SLOTrafficDeploymentPath="src/deployments/k6-slo-traffic";

if [ -z "$k6SLOTrafficRegistered" ]; then
  k6SLOTrafficRegistered=true;
  source "src/deployments/operator-httpbin/main.safe.sh";
  source "src/deployments/k6/main.safe.sh";
  source "$k6SLOTrafficDeploymentPath/openshift.sh";
  source "$k6SLOTrafficDeploymentPath/main.sh";
fi
