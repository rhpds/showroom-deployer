{{/*
Chart name, truncated to 63 chars.
*/}}
{{- define "zerotouch.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Fully qualified app name using release name.
*/}}
{{- define "zerotouch.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels used in matchLabels and pod templates.
*/}}
{{- define "zerotouch.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zerotouch.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels applied to all resources.
*/}}
{{- define "zerotouch.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "zerotouch.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
