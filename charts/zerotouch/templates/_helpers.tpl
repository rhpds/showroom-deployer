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

{{/*
Baseline PodSecurity "restricted"-compliant securityContext for sidecars
that don't need anything special (i.e. everything except the terminal
container's own terminal.podman.enabled block, which genuinely needs
elevated capabilities this baseline forbids -- see values.yaml). Renders
only the value lines; callers provide the `securityContext:` key, e.g.:
  securityContext:
    {{- include "zerotouch.restrictedSecurityContext" . | nindent 10 }}
*/}}
{{- define "zerotouch.restrictedSecurityContext" -}}
allowPrivilegeEscalation: false
capabilities:
  drop: ["ALL"]
seccompProfile:
  type: RuntimeDefault
{{- end }}
