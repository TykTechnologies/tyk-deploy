logger "$INFO" "generating k6 traffic...";
port=$(kubectl get --namespace "$namespace" "service/gateway-svc-$tykReleaseName-$chart" -o json | jq '.spec.ports[0].port');
sed "s/replace_gateway_url/gateway-svc-$tykReleaseName-$chart.$namespace.svc:$port/g" "$k6SLOTrafficDeploymentPath/slo-traffic-configmap-template.yaml" | \
  sed "s/replace_listen_path/$(kubectl get --namespace "$namespace" tykapis httpbin-keyless -o json | jq -r '.spec.proxy.listen_path' | cut -c 2-)/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

test_name="k6-load-test-$(date +%s)";
sed "s/replace_test_name/$test_name/g" "$k6SLOTrafficDeploymentPath/k6-template.yaml" | \
sed "s/replace_run_as_user/$run_as_user/g" | \
sed "s/replace_fs_group/$fs_group/g" | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

logger "$INFO" "tests will continue to run in the background...";
