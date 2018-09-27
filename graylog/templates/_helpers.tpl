{{- define "mongo.connectionStringPrimary" -}}
{{- $nodes := dict "servers" (list) -}}
{{- range int (index .Values "mongodb-replicaset" "replicas") | until -}}
{{- $noop := printf "mongodb://%s:%s@%s-mongodb-replicaset-%d.mongodb-replicaset.%s.svc.cluster.local:%s" (index $.Values "mongodb-replicaset" "adminUser") (index $.Values "mongodb-replicaset" "adminPassword") $.Release.Name $.Release.Namespace (index $.Values "mongodb-replicaset" "port") | append $nodes.servers | set $nodes "servers" -}}
{{- end -}}
{{- join "," $nodes.servers -}}
{{- end -}}