if ! [ -f "$selfSignedCertsDeploymentPath/certs/tykCA.pem" ]; then
  source "$selfSignedCertsDeploymentPath/generate.sh";
fi

logger "$INFO" "creating self-signed certs secret...";

selfSignedCertsSecretName="self-signed-ca-secret";
selfSignedCertsVolumeName="self-signed-ca-volume";
selfSignedCertsMountPath="/etc/ssl/certs";
selfSignedCertsFilename="tykCA.pem";

kubectl create secret generic "$selfSignedCertsSecretName" \
  --from-file="$selfSignedCertsFilename=$selfSignedCertsDeploymentPath/certs/$selfSignedCertsFilename" \
  --dry-run=client -o=yaml | \
  kubectl apply --namespace "$namespace" -f - > /dev/null;

args=(--set "dash.extraVolumes[$dashExtraVolumesCtr].name=$selfSignedCertsVolumeName" \
  --set "dash.extraVolumes[$dashExtraVolumesCtr].secret.secretName=$selfSignedCertsSecretName" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].name=$selfSignedCertsVolumeName" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].mountPath=$selfSignedCertsMountPath/$selfSignedCertsFilename" \
  --set "dash.extraVolumeMounts[$dashExtraVolumeMountsCtr].subPath=$selfSignedCertsFilename" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].name=$selfSignedCertsVolumeName" \
  --set "gateway.extraVolumes[$gatewayExtraVolumesCtr].secret.secretName=$selfSignedCertsSecretName" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].name=$selfSignedCertsVolumeName" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].mountPath=$selfSignedCertsMountPath/$selfSignedCertsFilename" \
  --set "gateway.extraVolumeMounts[$gatewayExtraVolumeMountsCtr].subPath=$selfSignedCertsFilename");

dashExtraVolumesCtr=$((dashExtraVolumesCtr + 1));
dashExtraVolumeMountsCtr=$((dashExtraVolumeMountsCtr + 1));
gatewayExtraVolumesCtr=$((gatewayExtraVolumesCtr + 1));
gatewayExtraVolumeMountsCtr=$((gatewayExtraVolumeMountsCtr + 1));

addDeploymentArgs "${args[@]}";
upgradeTyk;
