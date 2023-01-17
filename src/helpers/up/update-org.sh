terminateDashboardPort() {
  set +e;
  pid=$(pgrep -f "svc/dashboard-svc-$tykReleaseName");
  set -e;

  if [[ -n "$pid" ]]; then
    logger "$DEBUG" "terminating dashboard port-forwarding ($pid)";
    kill -9 "$pid" 2>&1;
  fi
}

ORG_FILENAME=myorg.json;
FORWARD_PORT=3999;

dashURL=$(kubectl get secrets tyk-operator-conf -n "$namespace" -o=jsonpath='{.data.TYK_URL}' | base64 -d | cut -d '/' -f3);
orgID=$(kubectl get secrets tyk-operator-conf -n "$namespace" -o=jsonpath='{.data.TYK_ORG}' | base64 -d);
domain=$(echo "$dashURL" | cut -d ':' -f1);
port=$(echo "$dashURL" | cut -d ':' -f2);

logger "$DEBUG" "Dashboard URL: $dashURL";
logger "$DEBUG" "Organisation ID: $orgID";

tykReleaseName=$1;

terminateDashboardPort;
(kubectl port-forward "svc/dashboard-svc-$tykReleaseName" -n "$namespace" $FORWARD_PORT:$port > /dev/null &)

setVerbose;
sleep 5;
curl -s "localhost:$FORWARD_PORT/admin/organisations/$orgID" -H "Admin-Auth: 12345" > $ORG_FILENAME;

tmp=$(mktemp)
jq '.hybrid_enabled = true | .event_options = {
  "key_event": {
    "email": "test@test.com"
  },
  "hashed_key_event": {
    "email": "test@test.com"
  }
}' myorg.json > "$tmp" && mv "$tmp" myorg.json;

curl -s -X PUT "localhost:$FORWARD_PORT/admin/organisations/$orgID" -H "Admin-Auth: 12345" -d @$ORG_FILENAME > /dev/null;

rm $ORG_FILENAME;
unsetVerbose;
