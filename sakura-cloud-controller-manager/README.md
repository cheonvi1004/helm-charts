# Cloud Controller Manager for SAKURA Cloud

`sakura-cloud-controller-manager` is the Kubernetes cloud controller manager implementation for the [SAKURA Cloud](https://cloud.sakura.ad.jp/).

This chart bootstraps `sakura-cloud-controller-manager` in your Kubernetes cluster.

## Prerequisites

- [Kubernetes](https://kubernetes.io/) 1.12+ with RBAC enabled
- An SAKURA CLOUD API Key

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

Next, install from the sacloud repo:

```console
$ helm install sacloud/sakura-cloud-controller-manager --name sakura-cloud-controller-manager \
  --set sacloud.accessToken=$SAKURACLOUD_ACCESS_TOKEN \
  --set sacloud.accessTokenSecret=$SAKURACLOUD_ACCESS_TOKEN_SECRET \
  --set sacloud.zone=$SAKURACLOUD_ZONE
```

## Uninstalling the Chart

To uninstall/delete the `sakura-cloud-controller-manager` deployment:

```console
$ helm delete sakura-cloud-controller-manager --purge
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Configuration

The following tables lists the configurable parameters of the `sakura-cloud-controller-manager` chart and their default values.

| Parameter                   | Description | Default |
| --------------------------- | ----------- | ------- |
| `controller.image.repository` | Docker image location, _without_ the tag. | `"sacloud/sakura-cloud-controller-manager"` |
| `controller.image.tag`        | Tag / version of the Docker image. | `"0.2.0"` |
| `controller.image.pullPolicy` | `"IfNotPresent"`, `"Always"`, or `"Never"`; When launching a pod, this option indicates when to pull the OSBS Docker image. | `"IfNotPresent"` |
| `sacloud.accessToken`         | SAKURA CLOUD API access-token. | none |
| `sacloud.accessTokenSecret`   | SAKURA CLOUD API access-token-secret. | none |
| `sacloud.zone`                | Target zone. | none |
| `sacloud.clusterID`           | Target kubernetes cluster ID. | none |

Specify a value for each option using the `--set <key>=<value>` switch on the
`helm install` command. That switch can be invoked multiple times to set
multiple options.

Alternatively, copy the charts default values to a file, edit the file to your
liking, and reference that file in your `helm install` command:

```console
$ helm inspect values sacloud/sakura-cloud-controller-manager > my-values.yaml
$ vim my-values.yaml
$ helm install sacloud/sakura-cloud-controller-manager --name sakura-cloud-controller-manager --values my-values.yaml
```

