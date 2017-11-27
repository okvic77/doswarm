# Docker swarm

Create a docker swarm on Digitalocean within minutes.

```bash

packer build -var 'terraformUser=okvic77' -var 'digitalOceanToken=XXX' packer.json
terraform apply

```