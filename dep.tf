
variable "digitalocean_token" {}
variable "packer_image" {}
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}


variable "swarm_workers" {
  default = 2
}
variable "swarm_managers" {
  default = 2
}

