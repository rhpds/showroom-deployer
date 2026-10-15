{{/*
Baseline PodSecurity "restricted"-compliant securityContext for sidecars
that don't need anything special (i.e. everything except the terminal
container's own terminal.podman.enabled block, which genuinely needs
elevated capabilities this baseline forbids -- see values.yaml). Renders
only the value lines; callers provide the `securityContext:` key, e.g.:
  securityContext:
    {{- include "showroom-single-pod.restrictedSecurityContext" . | nindent 10 }}
*/}}
{{- define "showroom-single-pod.restrictedSecurityContext" -}}
allowPrivilegeEscalation: false
capabilities:
  drop: ["ALL"]
seccompProfile:
  type: RuntimeDefault
{{- end }}
