job "egw" {

  datacenters = ["dc1"]

  group "egw" {
    count = 2
    network {
      mode = "bridge"
    }

    service {
      name = "egw"

      connect {
        gateway {
          proxy {}
          terminating {
            service {
              name = "postgres"
            }
          }
        }
      }
    }
  }
}
