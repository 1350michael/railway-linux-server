# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install essential packages
RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    curl \
    wget \
    nano \
    htop \
    git \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:railway123' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Configure Nginx
RUN echo '<!DOCTYPE html><html><head><title>Railway Linux Server</title></head><body><h1>🚂 Railway Linux Server Running!</h1><p>Your server is live and accessible.</p><p>SSH Password: railway123</p></body></html>' > /var/www/html/index.html

# Configure Nginx to run on Railway's required PORT
RUN sed -i 's/listen 80 default_server;/listen $PORT default_server;/' /etc/nginx/sites-available/default
RUN sed -i 's/listen \[::\]:80 default_server;/listen [::]:$PORT default_server;/' /etc/nginx/sites-available/default

# Create startup script
RUN echo '#!/bin/bash\n\
# Start SSH service\n\
service ssh start\n\
\n\
# Update Nginx config with Railway PORT\n\
sed -i "s/\$PORT/${PORT:-8080}/g" /etc/nginx/sites-available/default\n\
\n\
# Start Nginx in foreground\n\
nginx -g "daemon off;"\n\
' > /start.sh && chmod +x /start.sh

# Expose the port Railway expects
EXPOSE $PORT

# Run the startup script
CMD ["/start.sh"]
