services=();

addService() {
  services+=($1);
}

getPort() {
  set +e;
  port=$(kubectl get svc --namespace "$namespace" "$1" -o jsonpath="{.spec.ports[0].port}");
  set -e;
}

terminatePorts() {
  for service in "${services[@]}"; do
    getPort "$service";

    set +e;
    pid=$(pgrep -f "$service --namespace");
    set -e;

    if [[ -n "$pid" ]]; then
      logger "$DEBUG" "terminating port-forwarding ($pid) on port: $port";
      kill -9 "$pid" 2>&1;
    fi
  done
}

exposeServices() {
  servicesSummary="";
  if [[ $PORTFORWARD == "$expose" ]]; then
    terminatePorts;
    logger "$DEBUG" "expose set to port-forward";

    for service in "${services[@]}"; do
      getPort "$service";
      kubectl port-forward "svc/$service" --namespace "$namespace" $port > /dev/null &
      logger "$DEBUG" "forwarding to $protocol://localhost:$port \tfrom\t svc/$service:$port";
      servicesSummary="$servicesSummary\n\t$(printf "%-60s" "$service") $protocol://localhost:$port";
    done
    addSummary "\tExposed Services$servicesSummary";
  elif [[ $INGRESS == "$expose" ]]; then
    addSummary "\tServices can be access through ingress...";
  elif [[ $LOADBALANCER == "$expose" ]]; then
      addSummary "\tServices can be access through loadbalancers...";
  fi
}

cleanPorts() {
  services=($(kubectl get svc --namespace "$namespace" | awk 'NR > 1 {print $1}'));
  terminatePorts;
}
