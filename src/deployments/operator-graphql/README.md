## Tyk Operator GraphQL Example
Deploys the Tyke Operator [Tyk Operator](https://github.com/TykTechnologies/tyk-operator) and its dependency
[cert-manager](https://github.com/jetstack/cert-manager). This will also stand up a Federation v1 API
example using the tyk-operator.

The following API definitions will be created with this deployment:
- TrevorBlades Countries example

### Minikube
To run on `minikube` you must enable ingress addons

```
minikube start
minikube addons enable ingress
```

### Example
```
./up.sh --deployments operator-graphql tyk-stack
```

### Support
|     Item     |       Status       |
|:------------:|:------------------:|
|  OpenShift   | :white_check_mark: |
|   CI Tests   | :white_check_mark: |
| Postman Test | :white_check_mark: |
|     SSL      |        N/A         |

### Supported Service Types with `--expose` flag
|     Item      | Status |
|:-------------:|:------:|
| Port Forward  |  N/A   |
|    Ingress    |  N/A   |
| Load Balancer |  N/A   |

|        Icon        |        Description        |
|:------------------:|:-------------------------:|
| :white_check_mark: |   Supported and tested    |
|     :warning:      |        Not tested         |
|        :x:         |       Not supported       |
|     :no_entry:     | Not supported by the tool |
