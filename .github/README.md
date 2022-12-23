# tyk-k8s-demo
[![Smoke Tests](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/smoke-test.yml/badge.svg)](https://github.com/TykTechnologies/tyk-k8s-demo/actions/workflows/smoke-test.yml)

## About
Will allow you to deploy the entire Tyk stack for POC on k8s.

## Purpose
Minimize the amount of effort needed to stand up the Tyk infrastructure and show examples of how Tyk can be setup in k8s using different deployment architectures as well as different technologies integrations.

## Getting started

#### Prerequisites
- Helm
- jq
- git

#### Initial setup
Create `.env` file

```
cp .env.example .env
```

## Possible deployments
- `tyk-pro`: Tyk pro self-managed single region
- `tyk-cp`: Tyk pro self-managed multi region control plane
- `tyk-worker`: Tyk worker gateway, this can connect to Tyk Cloud or a Tyk Control Plane
- `tyk-gateway`: Tyk oss self-managed single region

## Dependencies Options
### Redis Options
- `redis`: Bitnami Redis deployment
- `redis-cluster`: Bitnami Redis Cluster deployment
- `redis-sentinel`: Bitnami Redis Sentinel deployment

### Storage Options
- `mongo`: Bitnami Mongo database deployment as a Tyk backend
- `postgres`: Bitnami Postgres database deployment as a Tyk backend

### Deployments
- [k6 Traffic Generator](../src/deployments/k6-traffic-generator)
- [Operator](../src/deployments/operator)
	- [HttpBin](../src/deployments/operator-httpbin)
	- [GraphQL](../src/deployments/operator-graphql)
- [Portal](../src/deployments/portal)
- Pumps
  - [Prometheus](../src/deployments/pump-prometheus)

## Usage
```
Usage:
  ./up.sh [flags] [command]

Available Commands:
  tyk-pro
  tyk-cp
  tyk-worker
  tyk-gateway

Flags:
  -v, --verbose     	bool   	 set log level to debug
      --dry-run     	bool   	 set the execution mode to dry run. This will dump the kubectl and helm commands rather than execute them
  -n, --namespace   	string 	 namespace the tyk stack will be installed in, defaults to 'tyk'
  -f, --flavor      	enum   	 k8s environment flavor. This option can be set 'openshift' and defaults to 'vanilla'
  -e, --expose      	enum   	 set this option to 'port-forward' to expose the services as port-forwards or to 'load-balancer' to expose the services as load balancers or 'ingress' which exposes services as a k8s ingress object.
  -r, --redis       	enum   	 the redis mode that tyk stack will use. This option can be set 'redis-cluster', 'redis-sentinel' and defaults to 'redis'
  -s, --storage     	enum   	 database the tyk stack will use. This option can be set 'postgres' and defaults to 'mongo'
  -d, --deployments 	string 	 comma separated list of deployments to launch
```

```
Usage:
  ./down.sh [flags]

Flags:
  -v, --verbose   	bool   	 set log level to debug
  -n, --namespace 	string 	 namespace the tyk stack will be installed in, defaults to 'tyk'
  -p, --ports     	bool   	 disconnect port connections only
```

## Variables
You can add any Tyk environments variables to the `.env` file and they will be mapped to the respective extraEnvs section in the helm charts.

| Variable                    |       Default       | Comments                                                   |
|-----------------------------|:-------------------:|------------------------------------------------------------|
| TYK_DASHBOARD_VERSION       |      `v4.3.1`       | Dashboard version                                          |
| TYK_GATEWAY_VERSION         |      `v4.3.1`       | Gateway version                                            |
| TYK_MDCB_VERSION            |      `v2.0.4`       | MDCB version                                               |
| TYK_PUMP_VERSION            |      `v1.7.0`       | Pump version                                               |
| TYK_PORTAL_VERSION          |      `v1.0.1`       | Portal version                                             |
| TYK_HELM_CHART_PATH         |     `tyk-helm`      | Path to charts, can be a local directory or a helm repo    |
| PASSWORD                    | `topsecretpassword` | Default password for all the services deployed             |
| LICENSE                     |                     | Dashboard license                                          |
| MDCB_LICENSE                |                     | MDCB license                                               |
| PORTAL_LICENSE              |                     | Portal license                                             |
| TYK_WORKER_CONNECTIONSTRING |                     | MDCB URL for worker connection                             |
| TYK_WORKER_ORGID            |                     | Org ID of dashboard user                                   |
| TYK_WORKER_AUTHTOKEN        |                     | Auth token of dashboard user                               |
| TYK_WORKER_USESSL           |       `true`        | Set to `true` when the MDCB is serving on a TLS connection |
| TYK_WORKER_GW_PORT          |       `8081`        | Set the gateway service port to use                        |

## Features compatibility & tests matrix
| Depoloyment          |             `--expose` Support             |   Postman Tests    | OpenShift Support  |
|----------------------|:------------------------------------------:|:------------------:|:------------------:|
| tyk-gateway          | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: |
| tyk-worker           | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: |
| tyk-pro              | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: |
| tyk-cp               | `port-froward`, `ingress`, `load-balancer` | :white_check_mark: | :white_check_mark: |
| k6-traffic-generator |                    N/A                     |        N/A         |   :construction:   |
| operator             |                    N/A                     |        N/A         |   :construction:   |
| operator-graphql     |               `port-froward`               | :white_check_mark: |   :construction:   |
| operator-httpbin     |               `port-froward`               |   :construction:   |   :construction:   |
| portal               | `port-froward`, `ingress`, `load-balancer` |   :construction:   | :white_check_mark: |
| pump-prometheus      |               `port-froward`               |   :construction:   |   :construction:   |

:white_check_mark: Built/Compatible
:construction: Working on it
