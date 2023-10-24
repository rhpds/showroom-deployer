{{- define "namespace.labels" }}
  labels:
    catalogItem: "{{ .Values.general.catalogItem | toString | lower }}"
    guid: "{{ .Values.general.guid | toString | lower }}"
    app: "showroom"
{{- end }}

{{- define "namespace.name" }} {{ .Values.general.namespace | toString | lower }}-{{ .Values.general.guid | toString | lower }}-{{ .Values.general.catalogItem | toString | lower }}
{{- end }}

{{- define "htmlnamespace.name" }}{{ .general.namespace | toString | lower }}-{{ .general.guid | toString | lower }}-{{ .general.catalogItem | toString | lower }}
{{- end }}

{{- define "showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- $tmpnamespace := include "htmlnamespace.name" $values -}}
{{- printf "https://showroom-proxy-%s.%s/%s" $tmpnamespace $values.deployer.domain $service }}
{{- end }}
