#!/bin/bash
set -e

source src/helpers/logger.sh
source src/helpers/check-deps.sh;
source src/helpers/down/usage.sh;
source src/helpers/down/init-args.sh;
source src/helpers/port-forward.sh;

cleanPorts;

if ! $ports; then
  kubectl delete namespace $namespace;
fi
