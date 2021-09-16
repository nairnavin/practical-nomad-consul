{
"host":
[
{{- range $index,  $service := service "nomad-client" }} "{{.Node}}:{{.Address}}"{{if ne $index (subtract 1 (service "nomad-client" | len))}},{{end}}
{{end}}
]
}