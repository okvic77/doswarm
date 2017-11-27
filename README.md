# Docker swarm

Create a docker swarm on Digitalocean within minutes.

```sh
# Run once, or to update Docker
packer build -var 'packer_image=CHANGE/base' -var 'digitalOceanToken=XXX' packer.json

# Run to initialize terraform
terraform init

# Run when required, to scale, upgrade or delete.
terraform apply -var digitalocean_token=XXX -var packer_image=CHANGE/base

```