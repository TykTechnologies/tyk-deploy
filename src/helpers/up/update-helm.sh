logger "$INFO" "update helm repos...";
helm repo add tyk-helm https://helm.tyk.io/public/helm/charts/ > /dev/null;
helm repo add bitnami https://charts.bitnami.com/bitnami > /dev/null;
helm repo add jetstack https://charts.jetstack.io > /dev/null;
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts > /dev/null;
helm repo add grafana https://grafana.github.io/helm-charts > /dev/null;
helm repo add datadog https://helm.datadoghq.com > /dev/null;
helm repo add resurfaceio https://resurfaceio.github.io/containers > /dev/null;
helm repo update > /dev/null;
