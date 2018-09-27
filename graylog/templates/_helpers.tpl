{{- define "mongo.connectionString" -}}
{{- $nodes := dict "servers" (list) -}}
{{- range int . | until -}}
{{- $noop := printf "mongodb://%s:%s@%s-mongodb-replicaset-%d.mongodb-replicaset.%s.svc.cluster.local" .Values.mongodb-replicaset.adminUser .Values.mongodb-replicaset.adminPassword .Release.Name .Release.Namespace .Values.mongodb-replicaset.port .Values.mongodb-replicaset.replicaSetName | append $nodes.servers -}}
{{- end -}}
{{- join "," $nodes.servers -}}
{{- end -}}