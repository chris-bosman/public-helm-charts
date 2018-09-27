# Auth0Forwarder Helm Chart

* Installs all necessary components to run the containerized auth0-to-graylog2 container as described here.

## TL;DR

```terminal
$ helm repo add cbosman 'https://raw.githubusercontent.com/chris-bosman/public-helm-charts/master/'
$ helm repo update
$ helm install cbosman/auth0forwarder
```

## Adding this repository

To add this repository, perform the following commands:

```terminal
$ helm repo add cbosman 'https://raw.githubusercontent.com/chris-bosman/public-helm-charts/master/'
$ helm repo update
```

## Installing the Chart

To install the chart with the release name `my-release`:

`$ helm install --name my-release cbosman/auth0forwarder`

## Uninstalling the CHart

To uninstall/delete the `my-release` deployment:

`$ helm delete --purge my-release`

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

| Parameter                       | Description                                   | Default                                                 |
|---------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `app.name`                       | Name that will be given for all k8s resources.                             | `auth0-forwarder`                                                     |
| `app.namespace`            | Namespace in which to deploy the resources.                       | `default`                                         |
| `image.registry`                | Image registry name                           | `racecarbrown`                                          |
| `image.name`                    | Image repository name                         | `auth0forwarder`                                        |
| `image.tag`                     | Image tag                                     | `0.1`                                                   |
| `pod.resources`                     | CPU/Memory resource requests/limits           | `{}`                                                    |
| `auth.clientId`                   | Auth0 Client ID                             | `""` |
| `auth.clientSecret`                | Auth0 Client Secret                       | `""` |
| `auth.domain`                     | Auth0 Domain                              | `""`  |
| `forwarder.batchSize`             | Number of logs to forwarder per batch (Max 100)   | `100` |
| `forwader.startFrom`              | Integer value that designates the log number from which to start forwarding Auth0 logs. Choose '0' to forward all logs. | `0` |
| `forwarder.pollingInt`            | Interval in seconds between batch forwarding processes.   | `30`  |
| `forwarder.trackInt`              | To allow Auth0 enough time to index new logs properly, once the forwarder reaches the end of all logs, it will wait a number of seconds equal to this value before pushing additional batches.    | `600` |
| `forwarder.clientFilter.enabled`  |   If you would like to filter out specific Auth0 clientIDs from your logs, set this to `true`. | `false`  |
| `forwarder.clientFilter.ids`      | If `forwarder.clientFilter.enabled` is set to `true`, then use this setting to provide a comma delimited list of the IDs you would like to skip.  |   `""`    |
| `forwarder.localLogging.enabled`          | If you would like your forwarder to also retain logs locally, set this to `true`. | `false` |
| `forwarder.localLogging.storageSpace`     | If `forwarder.localLogging.enabled` is set to true, this value determines how much disk space to provide the PersistentVolumeClaim for storing the local logs.    | `10Gi`    |
| `forwarder.localLogging.storageClass`      | If you want to provide a specific `storageClass` for your PVC, do so here.   | `default` |
| `graylog.host`    |   The URL of your Graylog GELF HTTP input. |   `http://graylog.example.com`    |
| `graylog.port`    |   The port assigned to your Graylog GELF HTTP input.  | `12201`   |
| `graylog.metadata`    | Any value provided to this field will show up in your Graylog logs with the field `meta:<this-value>`. This field is not required.    | `auth0`   |

## Local Logging

The logs you forward to Graylog will be stored in your Elasticsearch cluster. However, if you'd like to save the within the forwarder, you can do that. By setting `forwarder.localLogging.enabled` to true, this chart will provision a Persistent Volume Claim where the logs will be stored in a manner locally accessible to the pod. The location of the logs will be /app/logs/auth0.log

## Next Steps

The auth0 logs, when imported into Graylog, will not have any searchable fields (aside from the `meta` field defined via the value of `graylog.metadata`). This is because, by default, the logs will be imported into Graylog as raw JSON. You will want to enable Graylog's JSON extractor for the GELF HTTP Input you set up. You can find documentation on how to do that [here](http://docs.graylog.org/en/2.4/pages/extractors.html#using-the-json-extractor).