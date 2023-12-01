{{/* vim: set filetype=mustache: */}}

{{/*
Create a showroom route for the HTML page
*/}}
{{- define "showroom-deployer.showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- printf "https://showroom-%s.%s/%s" $values.namespace.name $values.deployer.domain $service }}
{{- end -}}
