#!/bin/bash

export PRIVATE_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address)

docker swarm init --advertise-addr $PRIVATE_IPV4

curl -L https://storage.googleapis.com/neimx/binaries/swarmtoken > /usr/local/bin/swarmtoken
chmod +x /usr/local/bin/swarmtoken

/bin/cat <<EOM > /etc/systemd/system/swarmtoken.service
[Unit]
Description=Run server http to generate swarm tokens
After=docker.service
Requires=docker.service

[Install]
WantedBy=multi-user.target

[Service]
Restart=always
ExecStart=/usr/local/bin/swarmtoken
EOM

systemctl enable swarmtoken
systemctl start swarmtoken
