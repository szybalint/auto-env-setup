#!/bin/bash

echo "---------------------------------------"
echo "Installing docker..."
echo "---------------------------------------"

echo "---------------------------------------"
echo "Removing older versions..."
echo "---------------------------------------"

sudo apt remove docker docker-engine docker.io containerd runc

echo "---------------------------------------"
echo "Adding docker repository..."
echo "---------------------------------------"

sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

echo "---------------------------------------"
echo "Installing docker..."
echo "---------------------------------------"

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "---------------------------------------"
echo "Verifying installation..."
echo "---------------------------------------"

if ! sudo docker run hello-world; then
    echo "---------------------------------------"
    echo "Failed to run hello-world container,"
    echo "exiting..."
    echo "---------------------------------------"
    exit 1
fi

echo "---------------------------------------"
echo "Setting up non-root docker access..."
echo "---------------------------------------"

sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker
sudo rm -rf ~/.docker

echo "---------------------------------------"
echo "Verifying non-root access..."
echo "---------------------------------------"

if ! docker run hello-world; then
    echo "---------------------------------------"
    echo "Failed to run in non-root mode,"
    echo "exiting..."
    echo "---------------------------------------"
    exit 1
fi

echo "---------------------------------------"
echo "Enabling systemd services..."
echo "---------------------------------------"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "---------------------------------------"
echo "Docker installed successfully, njoy!"
echo "---------------------------------------"