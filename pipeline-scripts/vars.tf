variable "artifact-user" {
  default = "jenkins"
}

variable "artifact-pass" {
  default = "Admin%40123"
}

variable "angular-artifact-suffix" {

    default = "10.0.2.2:9082/artifactory/Spring-Petclinic-Angular-Local"

}

variable "rest-artifact-suffix" {

    default = "10.0.2.2:9082/artifactory/Spring-Petclinic-Rest-Local"

}

variable "angular-artifact-id" {
  default = ""
}

variable "rest-artifact-id" {
  default = ""
}