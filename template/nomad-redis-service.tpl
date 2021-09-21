{{- range service "redis" }} {{.Address}}:{{.Port}} 
{{end}} 