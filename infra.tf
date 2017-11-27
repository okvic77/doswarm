data "atlas_artifact" "base" {
  name = "CHANGEHERE/docker-base"
  type = "digitalocean.image"
  version = "1"
}

resource "digitalocean_droplet" "master" {
  name = "${terraform.env}-manager-0"
  image = "${element(split(":", data.atlas_artifact.base.id), 1)}"
  region = "sfo2"
  size   = "s-1vcpu-3gb"
  private_networking = true
  resize_disk = false
  user_data = "${file("./prov-master.sh")}"
  # ssh_keys = ["xx"]
}

output "sshmaster" {
  value = "root@${digitalocean_droplet.master.ipv4_address}"
}

resource "digitalocean_droplet" "manager" {
  # ssh_keys = ["xx"]
  count = 2
  name = "${terraform.env}-manager-${count.index + 1}"
  image = "${element(split(":", data.atlas_artifact.base.id), 1)}"
  region = "sfo2"
  size   = "s-1vcpu-3gb"
  private_networking = true
  resize_disk = false
  user_data = <<EOF
#!/bin/bash
export SWARM_TOKEN=$(curl -s http://${digitalocean_droplet.master.ipv4_address_private}:8000/manager)
docker swarm join --token $SWARM_TOKEN ${digitalocean_droplet.master.ipv4_address_private}:2377
EOF
}



resource "digitalocean_droplet" "worker" {
  # ssh_keys = ["xx"]
  count = 2
  name = "${terraform.env}-worker-${count.index + 1}"
  image = "${element(split(":", data.atlas_artifact.base.id), 1)}"
  region = "sfo2"
  size   = "s-1vcpu-3gb"
  private_networking = true
  resize_disk = false
  user_data = <<EOF
#!/bin/bash
export SWARM_TOKEN=$(curl -s http://${digitalocean_droplet.master.ipv4_address_private}:8000/worker)
docker swarm join --token $SWARM_TOKEN ${digitalocean_droplet.master.ipv4_address_private}:2377
EOF
}



