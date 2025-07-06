# Railway Linux Server

A full Ubuntu 22.04 Linux server running on Railway with SSH access and a web server.

## What's Included

- **Ubuntu 22.04 LTS** base system
- **Nginx** web server 
- **SSH server** for remote access
- **Development tools**: git, nano, htop, curl, wget
- **Runtime environments**: Python 3, Node.js

## Quick Deploy to Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/CvAgGT)

## Manual Setup

1. Fork this repository
2. Create a new project on [Railway](https://railway.app)
3. Connect this GitHub repository
4. Deploy!

## Access Information

- **Web Interface**: Available at your Railway domain
- **SSH Access**: Use Railway's built-in terminal or connect externally
- **SSH Password**: `railway123` (change this for production use)

## Default Services

- Nginx runs on the Railway-assigned PORT
- SSH server runs on port 22
- All common development tools pre-installed

## Security Note

This configuration is for **testing purposes only**. For production use:
- Change the default SSH password
- Configure proper SSH key authentication
- Set up a firewall
- Use environment variables for sensitive data

## Customization

Edit the `Dockerfile` to add additional packages or configurations:

```dockerfile
RUN apt-get install -y your-package-here
```
