job "petclinic-egw" {

  datacenters = ["dc1"]

  group "petclinic-egw" {
    count = 2
    network {
      mode = "bridge"
    }

    service {
      name = "petclinic-egw"

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
