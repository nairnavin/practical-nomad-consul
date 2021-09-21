job "autoscaler" {
  type = "service"

  datacenters = ["dc1"]

  group "autoscaler" {
    count = 1

    network {
      port "http" {}
      port "promtail" {}
    }

    task "autoscaler" {
      driver = "docker"

      config {
        image   = "hashicorp/nomad-autoscaler:0.3.3"
        command = "nomad-autoscaler"
        ports   = ["http"]

        args = [
          "agent",
          "-config",
          "${NOMAD_TASK_DIR}/config.hcl",
          "-http-bind-address",
          "0.0.0.0",
          "-http-bind-port",
          "${NOMAD_PORT_http}",
        ]
      }

      template {
        data = <<EOH
nomad {
  address = "http://172.16.1.101:4646"
}
telemetry {
  prometheus_metrics = true
  disable_hostname   = true
}
apm "prometheus" {
  driver = "prometheus"
  config = {
    address = "http://{{ range service "prometheus" }}{{ .Address }}:{{ .Port }}{{ end }}"
  }
}
strategy "target-value" {
  driver = "target-value"
}
          EOH

        destination = "${NOMAD_TASK_DIR}/config.hcl"
      }

      resources {
        cpu    = 50
        memory = 128
      }

      service {
        name = "autoscaler"
        port = "http"

        check {
          type     = "http"
          path     = "/v1/health"
          interval = "3s"
          timeout  = "1s"
        }
      }
    }
  }
}