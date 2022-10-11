ORG_FILENAME=myorg.json

dashURL=$(kubectl get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_URL}' | base64 -d | cut -d '/' -f3)
orgID=$(kubectl get secrets tyk-operator-conf -n $namespace -o=jsonpath='{.data.TYK_ORG}' | base64 -d)
domain=$(echo $dashURL | cut -d ':' -f1)
port=$(echo $dashURL | cut -d ':' -f2)

kubectl port-forward svc/dashboard-svc-tyk-pro -n $namespace $port > /dev/null 2>&1 &

pid=$!

set -x
sleep 30
curl localhost:$port/admin/organisations/$orgID -H "Admin-Auth: 12345" > $ORG_FILENAME

tmp=$(mktemp)
jq '.hybrid_enabled = true | .event_options = {
  "key_event": {
    "email": "test@test.com"
  },
  "hashed_key_event": {
    "email": "test@test.com"
  }
}' myorg.json > "$tmp" && mv "$tmp" myorg.json

curl -X PUT localhost:$port/admin/organisations/$orgID -H "Admin-Auth: 12345" -d @$ORG_FILENAME

trap "kill $pid" EXIT
rm $ORG_FILENAME

set +x
