{{/* vim: set filetype=mustache: */}}

{{- define "showroom-deployer.namespace.labels" }}
  labels:
    catalogItem: "{{ .Values.general.catalogItem | toString | lower }}"
    guid: "{{ .Values.general.guid | toString | lower }}"
    app: "showroom"
{{- end -}}

{{/*
USE ONLY WHEN WE HAVE AGV COMPONENT NAME
If there's not already a namespace, create a namespace name from namespacename-guid-catalogItem
{{ define "showroom-deployer.namespace.name" }}
{{- end }}
*/}}

{{/*
If there's not already a namespace, create a namespace name from namespacename-guid
*/}}
{{ define "showroom-deployer.namespace.name" -}}
{{ if .Values.namespace -}}
{{ .Values.namespace | toString | lower -}}
{{ else if not .Values.general.aVcomponentName -}}
{{ .Values.general.namespace | toString | lower }}-{{ $.Values.general.guid | toString | lower -}}
{{ else -}}
{{ .Values.general.namespace | toString | lower }}-{{ $.Values.general.guid | toString | lower }}-{{ .Values.general.agVcomponentName | toString | lower -}}
{{ end -}}
{{ end -}}

{{/*
The HTML files need a differently scoped set of the same values as above,
used in the showroom-deployer.showroom.route template below.
Add conditions for AgVcomponentName when it comes along.
*/}}
{{- define "showroom-deployer.htmlnamespace.name" }}
{{- .general.namespace | toString | lower }}-{{ .general.guid | toString | lower }}
{{- end -}}

{{/*
Create a showroom route for the HTML page
*/}}
{{- define "showroom-deployer.showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- $tmpnamespace := include "showroom-deployer.htmlnamespace.name" $values -}}
{{- printf "https://showroom-proxy-%s.%s/%s" $tmpnamespace $values.deployer.domain $service }}
{{- end -}}
