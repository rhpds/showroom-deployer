{{/* vim: set filetype=mustache: */}}

{{- define "showroom-deployer.namespace.labels" }}
  labels:
    catalogItem: "{{ .Values.general.catalogItem | toString | lower }}"
    guid: "{{ .Values.general.guid | toString | lower }}"
    app: "showroom"
{{- end }}

{{/*
Create a namespace name from namespacename-guid-catalogItem
*/}}
{{- define "showroom-deployer.namespace.name" }} {{ .Values.general.namespace | toString | lower }}-{{ .Values.general.guid | toString | lower }}-{{ .Values.general.catalogItem | toString | lower }}
{{- end }}

{{/*
The HTML files need a differently scoped set of the same values as above
*/}}
{{- define "showroom-deployer.htmlnamespace.name" }}{{ .general.namespace | toString | lower }}-{{ .general.guid | toString | lower }}-{{ .general.catalogItem | toString | lower }}
{{- end }}

{{/*
Create a showroom route for the HTML page
*/}}
{{- define "showroom-deployer.showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- $tmpnamespace := include "htmlnamespace.name" $values -}}
{{- printf "https://showroom-proxy-%s.%s/%s" $tmpnamespace $values.deployer.domain $service }}
{{- end }}
