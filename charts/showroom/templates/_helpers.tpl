{{/* vim: set filetype=mustache: */}}

{{- define "showroom-deployer.namespace.labels" }}
  labels:
    guid: "{{ .Values.guid | toString | lower }}"
    app: "showroom"
{{- end -}}

{{/*
Create a showroom route for the HTML page
*/}}
{{- define "showroom-deployer.showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- printf "https://showroom-proxy-%s.%s/%s" $values.namespace.name $values.deployer.domain $service }}
{{- end -}}
