provider "nomad" {
  #address = "http://127.0.0.1:4646"
  address = "http://host.docker.internal:4646"
  #region  = "dc1"
}
# Addding the line 
# Register a job
resource "nomad_job" "petclinic_web" {
  #count = var.angular-artifact-id != "" ? 1 : 0
    hcl2 {
    enabled  = true
    vars = {
      "angular-artifact-url" = "http://${var.artifact-user}:${var.artifact-pass}@${var.angular-artifact-suffix}/${var.angular-artifact-id}"
    }
  }
  jobspec = file("${path.root}/../jobs/cd-jobs/petclinic-web.nomad")

}

resource "nomad_job" "petclinic_api" {
  #count = var.rest-artifact-id != "" ? 1 : 0
  hcl2 {
    enabled  = true
    vars = {
      "rest-artifact-url" = "http://${var.artifact-user}:${var.artifact-pass}@${var.rest-artifact-suffix}/${var.rest-artifact-id}",
      "rest-artifact-id" = "${var.rest-artifact-id}"
    }
  }
  jobspec = file("${path.root}/../jobs/cd-jobs/petclinic-api.nomad")
  
}