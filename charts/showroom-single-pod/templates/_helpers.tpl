{{- define "showroom-deployer.showroom.route" }}
{{- $service := index . 0 -}}
{{- $values := index . 1 -}}
{{- printf "https://showroom-%s.%s/%s" .Release.Namespace $values.deployer.domain $service }}
{{- end -}}
