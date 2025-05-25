#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install -y awscli ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's official GPG key and repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

internal_lb=$(aws ssm get-parameter --name "/three_tier/lb/internal_lb" --region us-east-1   --query "Parameter.Value" --output text)


cat <<EOF > /home/ubuntu/docker-compose.yml
services:
  frontend:
    image: ghcr.io/danielfarag/aws-3-tier-cicd-frontend:latest
    container_name: presentation_angular
    restart: on-failure
    volumes:
      - frontend-dist:/app
    networks:
      - frontend

  server:
    image: nginx:alpine
    container_name: presentation_nginx
    restart: on-failure
    ports:
      - "80:80"
    volumes:
      - frontend-dist:/usr/share/nginx/html
      - /home/ubuntu/nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - frontend
    networks:
      - frontend

volumes:
  frontend-dist:

networks:
  frontend:
EOF

cat <<EOF > /home/ubuntu/nginx.conf
events {
    worker_connections 1024;
}

http {
    include       mime.types; # Include MIME types mapping
    default_type  application/octet-stream; # Default MIME type

    server {
        listen 80;
        server_name localhost;

        root /usr/share/nginx/html;
        index index.html;

        location / {
            try_files \$uri \$uri/ /index.html;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|otf|eot|json)$ {
            try_files \$uri =404;
            access_log off;
            expires max;
            add_header Cache-Control "public, max-age=31536000, immutable";
        }

        location /api/ {
            proxy_pass http://${internal_lb}/;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOF

cd /home/ubuntu
docker compose up -d


