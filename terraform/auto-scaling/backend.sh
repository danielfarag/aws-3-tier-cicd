#!/bin/bash

sudo apt-get update
sudo apt-get install -y awscli ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

username=$(aws ssm get-parameter --name "/three_tier/rds/username" --with-decryption --region us-east-1   --query "Parameter.Value" --output text)
password=$(aws ssm get-parameter --name "/three_tier/rds/password" --with-decryption --region us-east-1   --query "Parameter.Value" --output text)
host=$(aws ssm get-parameter --name "/three_tier/rds/host" --region us-east-1   --query "Parameter.Value" --output text)
db_name=$(aws ssm get-parameter --name "/three_tier/rds/db_name" --region us-east-1   --query "Parameter.Value" --output text)


# Write docker-compose.yml file
cat <<EOF > /home/ubuntu/docker-compose.yml
version: '3'

services:

  backend:
    image: ghcr.io/danielfarag/aws-3-tier-cicd-backend:latest
    container_name: presentation_backend
    restart: unless-stopped
    ports:
      - "3000:3000"

    environment:
      DB_HOST: $host
      DB_NAME: $db_name
      DB_USER: $username
      DB_PASSWORD: $password

EOF

# Run docker-compose up
cd /home/ubuntu
docker compose up -d

