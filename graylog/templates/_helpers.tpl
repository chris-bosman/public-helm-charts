{{- define "mongo.connectionStringPrimary" -}}
{{- range $i, $e := until (atoi (quote (index $.Values "mongodb-replicaset" "replicas"))) | default 5 -}}
{{ printf "mongodb://graylog:Ilikech3353@graylog-mongodb-replicaset-$e.mongodb-replicaset.default.svc.cluster.local:27017" }}
{{- end -}}
{{- end -}}