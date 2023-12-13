logger "$INFO" "installing $certManagerReleaseName in $namespace namespace...";

setVerbose;
helm upgrade "$certManagerReleaseName" jetstack/cert-manager --version v1.10.1 \
  --install \
  --set "installCRDs=true" \
  --set "prometheus.enabled=false" \
  --namespace "$namespace" \
  "${helmFlags[@]}" > /dev/null;
unsetVerbose;
