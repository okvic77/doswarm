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


## Docker images

```bash
docker service create \
  --constraint 'node.role == manager' \
  --mount type=bind,source=/,destination=/rootfs,readonly=true \
  --mount type=bind,source=/var/run,destination=/var/run \
  --mount type=bind,source=/sys,destination=/sys,readonly=true \
  --mount type=bind,source=/var/lib/docker/,destination=/var/lib/docker,readonly=true \
  --mount type=bind,source=/dev/disk/,destination=/dev/disk,readonly=true \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
```