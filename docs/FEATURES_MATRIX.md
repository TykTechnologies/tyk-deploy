# Features, Tests, and Support matrices

| Deployment           | OpenShift Support  |    ARM Support     |      CI Tests      |    Postman Test    |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|
| tyk-gateway          | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-dp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-stack            | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-cp               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| datadog              | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| elasticsearch        | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: |        :x:         | :white_check_mark: |
| k6                   |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| k6-slo-traffic       |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak             |        :x:         |        :x:         | :white_check_mark: | :white_check_mark: |
| keycloak-dcr         |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-sso         |        :x:         |        :x:         | :white_check_mark: |        :x:         |
| keycloak-jwt         |        :x:         |        :x:         |        :x:         | :white_check_mark: |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: |        :x:         |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| portal               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus-grafana   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| resurface            |        :x:         |        :x:         | :white_check_mark: |        :x:         |


## Integrations compatible with Tyk deployments
| Integration          |    tyk-gateway     |     tyk-stack      |       tyk-cp       |       tyk-dp       |
|----------------------|:------------------:|:------------------:|:------------------:|:------------------:|
| datadog              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| elasticsearch        | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| elasticsearch-kibana | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6                   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| k6-slo-traffic       | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| keycloak-dcr         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| keycloak-jwt         |        N/A         | :white_check_mark: | :white_check_mark: |        N/A         |
| keycloak-sso         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator             | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-federation  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-graphql     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-httpbin     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-jwt-hmac    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| operator-udg         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| portal               |        N/A         | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus-grafana   | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| resurface            | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

## `--expose` flag support
| Deployment           |    port-froward    |      ingress       |   load-balancer    |
|----------------------|:------------------:|:------------------:|:------------------:|
| tyk-gateway          | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-dp               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-stack            | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| tyk-cp               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| datadog              | :white_check_mark: |        :v:         |        :x:         |
| elasticsearch        | :white_check_mark: |        :x:         |        :x:         |
| elasticsearch-kibana | :white_check_mark: |        :x:         |        :x:         |
| keycloak             | :white_check_mark: |        :x:         |        :x:         |
| operator-httpbin     | :white_check_mark: |        :x:         |        :x:         |
| operator-graphql     | :white_check_mark: |        :x:         |        :x:         |
| operator-udg         | :white_check_mark: |        :x:         |        :x:         |
| operator-federation  | :white_check_mark: |        :x:         |        :x:         |
| operator-jwt-hmac    | :white_check_mark: |        :x:         |        :x:         |
| portal               | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| prometheus           | :white_check_mark: |        :x:         |        :x:         |
| prometheus-grafana   | :white_check_mark: |        :x:         |        :x:         |
| resurface            | :white_check_mark: |        :x:         |        :x:         |
