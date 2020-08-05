#!/bin/bash
# Only for ubuntu 20
sudo apt install -y unzip openjdk-11-jre-headless
wget https://downloads.jboss.org/keycloak/11.0.0/keycloak-11.0.0.zip -P /tmp
unzip -q /tmp/keycloak-11.0.0.zip -d /home/ubuntu/
