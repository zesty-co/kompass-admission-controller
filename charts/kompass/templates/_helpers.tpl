{{/*
Helper Templates for kompass-admission-controller
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "kompass-admission-controller.name" -}}
{{- default "kompass-admission-controller" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kompass-admission-controller.fullname" -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- $name := default "kompass-admission-controller" .Values.nameOverride }}
    {{- if contains $name .Chart.Name }}
      {{- .Chart.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- printf "%s-%s" .Chart.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kompass-admission-controller.chart" -}}
  {{- printf "%s-%s" "kompass-admission-controller" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a config map name.
*/}}
{{- define "kompass-admission-controller.configMap" -}}
  {{- printf "%s-config" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a role name.
*/}}
{{- define "kompass-admission-controller.role" -}}
  {{- printf "%s-role" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a pdb name.
*/}}
{{- define "kompass-admission-controller.pdb" -}}
  {{- printf "%s-pdb" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a cr name.
*/}}
{{- define "kompass-admission-controller.cr" -}}
  {{- printf "%s-cr" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a sa name.
*/}}
{{- define "kompass-admission-controller.sa" -}}
  {{- printf "%s-sa" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a crb name.
*/}}
{{- define "kompass-admission-controller.crb" -}}
  {{- printf "%s-crb" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a rb name.
*/}}
{{- define "kompass-admission-controller.rb" -}}
  {{- printf "%s-rb" (include "kompass-admission-controller.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate a signed certificate for the admission controller.
*/}}
{{- define "kompass-admission-controller.cert" -}}
{{- $ca := genCA (printf "*.%s.svc" (.Release.Namespace)) 1024 -}}
{{- $svcName := printf "%s.%s.svc" (.Values.service.name) (.Release.Namespace) -}}
{{- $cert := genSignedCert $svcName nil (list $svcName) 1024 $ca -}}
{{- $certData := dict "CaCert" $ca.Cert "CaKey" $ca.Key "Cert" $cert.Cert "Key" $cert.Key -}}
{{- toYaml $certData -}}
{{- end -}}
