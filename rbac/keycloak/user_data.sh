#!/bin/bash
set -e

sudo apt update
sudo apt install -y  apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce

# Write the keycloack service file
sudo bash -c 'cat > /etc/systemd/system/keycloak.service' << EOF
[Unit]
Description=Keycloak Container
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=/usr/bin/docker pull quay.io/keycloak/keycloak:11.0.0
ExecStart=/usr/bin/docker run -p 8443:8443 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin quay.io/keycloak/keycloak:11.0.0

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl start keycloak
