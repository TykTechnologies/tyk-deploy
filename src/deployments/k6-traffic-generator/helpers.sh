checkK6OperatorExists() {
  set +e;
  search=$(kubectl get pods -n k6-operator-system 2> /dev/null | awk '{print $1}' | grep -e "^k6-operator-controller-manager-");
  logger "$DEBUG" "k6-operator-exists: search result: $search";
  set -e;

  if [[ -z $search ]]; then
    k6OperatorExists=false;
  else
    k6OperatorExists=true;
  fi
}

checkHttpBinCRDExists() {
  set +e;
  search=$(kubectl get -n "$namespace" tykapis httpbin-keyless);
  logger "$DEBUG" "httpbin-crd-exists: search result: $search";
  set -e;

  if [[ -z $search ]]; then
    httpBinCRDExists=false;
  else
    httpBinCRDExists=true;
  fi
}

waitForK6Jobs() {
  logger "$INFO" "waiting for jobs to start...";

  while : ; do
    sleep 1;

    set +e;
    search=$(kubectl get -n "$namespace" jobs "$load_test_name-1" 2> /dev/null | grep "$load_test_name-1");
    logger "$DEBUG" "job $load_test_name-1 not found";
    set -e;

    if ! [[ -z $search ]]; then
      break;
    fi
  done
}
