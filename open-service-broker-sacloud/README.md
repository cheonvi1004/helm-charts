# Open Service Broker for SAKURA CLOUD

[Open Service Broker for SAKURA CLOUD](https://github.com/sacloud/open-service-broker-sacloud) is the
open source, [Open Service Broker](https://www.openservicebrokerapi.org/)
compatible API server that provisions managed services in the [SAKURA CLOUD](https://cloud.sakura.ad.jp/).

This chart bootstraps Open Service Broker for SAKURA CLOUD in your Kubernetes cluster.

## Prerequisites

- [Kubernetes](https://kubernetes.io/) 1.7+ with RBAC enabled
- The
  [Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install.md)
  software has been installed
- An SAKURA CLOUD API Key
- The SAKURA CLOUD CLI(usacloud): You can
[install it locally](https://github.com/sacloud/usacloud)

For convenience in subsequent steps, we will export several of the fields above
as environment variables:

```console
$ export SAKURACLOUD_ACCESS_TOKEN=<your-api-token>
$ export SAKURACLOUD_ACCESS_TOKEN_SECRET=<your-api-secret>
$ export SAKURACLOUD_ZONE=<your-zone>
```

## Installing the Chart

Installation of this chart is simple. First, add the Sacloud charts repository to your local list:

```console
helm repo add sacloud https://sacloud.github.io/helm-charts/
```                                             

Next, install from the azure repo:

```console
$ helm install sacloud/open-service-broker-sacloud --name osbs --namespace osbs \
  --set sacloud.accessToken=$SAKURACLOUD_ACCESS_TOKEN \
  --set sacloud.accessTokenSecret=$SAKURACLOUD_ACCESS_TOKEN_SECRET \
  --set sacloud.zone=$SAKURACLOUD_ZONE
```

If you'd like to customize the installation, please see the 
[configuration](#configuration) section to see options that can be
configured during installation.

To verify the service broker has been deployed and show installed service classes and plans:

```console
$ kubectl get clusterservicebroker -o yaml

$ kubectl get clusterserviceclasses -o=custom-columns=NAME:.metadata.name,EXTERNAL\ NAME:.spec.externalName

$ kubectl get clusterserviceplans -o=custom-columns=NAME:.metadata.name,EXTERNAL\ NAME:.spec.externalName,SERVICE\ CLASS:.spec.clusterServiceClassRef.name --sort-by=.spec.clusterServiceClassRef.name
```

## Uninstalling the Chart

To uninstall/delete the `osbs` deployment:

```console
$ helm delete osbs --purge
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Configuration

The following tables lists the configurable parameters of the Azure Service
Broker chart and their default values.

| Parameter                   | Description | Default |
| --------------------------- | ----------- | ------- |
| `image.repository`          | Docker image location, _without_ the tag. | `"sacloud/sacloud-service-broker"` |
| `image.tag`                 | Tag / version of the Docker image. | `"0.0.2"` |
| `image.pullPolicy`          | `"IfNotPresent"`, `"Always"`, or `"Never"`; When launching a pod, this option indicates when to pull the OSBS Docker image. | `"IfNotPresent"` |
| `registerBroker`            | Whether to register this broker with the Kubernetes Service Catalog. If true, the Kubernetes Service Catalog must already be installed on the cluster. Marking this option false is useful for scenarios wherein one wishes to host the broker in a separate cluster than the Service Catalog (or other client) that will access it. | `true` |
| `service.type`              | Type of service; valid values are `"ClusterIP"` and `"NodePort"`. `"ClusterIP"` is sufficient in the average case where OSBA only receives traffic from within the cluster-- e.g. from Kubernetes Service Catalog. | `"ClusterIP"` |
| `service.nodePort.port`     | _If and only if_ `service.type` is set to `"NodePort"`, `service.nodePort.port` indicates the port this service should bind to on each Kubernetes node. | `30080` |
| `sacloud.accessToken`       | SAKURA CLOUD API access-token. | none |
| `sacloud.accessTokenSecret` | SAKURA CLOUD API access-token-secret. | none |
| `sacloud.zone`              | Target zone. | none |
| `basicAuth.username`        | Specifies the basic auth username that clients (e.g. the Kubernetes Service Catalog) must use when connecting to OSBA. | `"username"`; __Do not use this default value in production!__ |
| `basicAuth.password`        | Specifies the basic auth password that clients (e.g. the Kubernetes Service Catalog) must use when connecting to OSBA. | `"password"`; __Do not use this default value in production!__ |

Specify a value for each option using the `--set <key>=<value>` switch on the
`helm install` command. That switch can be invoked multiple times to set
multiple options.

Alternatively, copy the charts default values to a file, edit the file to your
liking, and reference that file in your `helm install` command:

```console
$ helm inspect values sacloud/open-service-broker-sacloud > my-values.yaml
$ vim my-values.yaml
$ helm install sacloud/open-service-broker-sacloud --name osbs --namespace osbs --values my-values.yaml
```

