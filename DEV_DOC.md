# Project Architecture
The infrastructure is composed of three services:
- **Nginx**:
    - Acts as a reverse proxy and handles HTTPS on port 443
    - It is the only exposed service
- **WordPress**:
    - Runs with PHP-FPM
    - Connects to the database
- **MariaDB**:
    - Stores WordPress data

Each service runs in it's own container and communicates through a custom Docker network.

# Prerequisites
Make sure the following tools are installed:
- Docker
- Docker Compose

You can verify installation with:
> docker --version

> docker compose version

# Setup from scratch
1. Clone the repository
> git clone *repo-SSH-link* *name-of-cloned-folder*

> cd *name-of-cloned-folder*

2. Configure environment variables
Create or edit the .env file
Fill in required values such as:
- DB-NAME
- DB-USER
- DB-PASSWORD
- WP-ADMIN-USER
- WP-ADMIN-PASSWORD

# Build and Run
To build images:
> make build

To start services:
> make up

# Containers Management
Start existing containers:
> make start

Stop containers:
> make stop

Remove containers and network:
> make down

List all containers:
> make ps

View logs:
> make logs

# Volumes and Data Persistence
Docker volumes are used to persist data:
- MariaDB volume stores database data
- WordPress volume stores website files

This ensures that data is preserved even if containers are removes.

To list volumes:
> make volumes

# Project Structure
Root directory contains:
- Makefile
- README.md
- USER-DOC.md
- DEV-DOC.md
- sources directory

Sources directory contains:
- docker-compose.yml
- .env
- requirements directory

Sources files are located in sources/requirements
- nginx/
- mariadb/
- wordpress/

# Networking
A custom Docker network is defined in docker-compose.yml
- Containers communicate using service names
- WordPress connects to MariaDB
- Nginx connects to WordPress

# Design Choices
- One service per container
- Custom Docker network for isolation
- Volumes for data persistence
- Environment variables for configuration
- Nginx as the only entry point (port 443)

# Notes for Development
- Images are based on Debian:bookworm
- Services are configured through custom Dockerfiles
- Environment variables are used instead of Docker secrets

# Useful Commands
Rebuild everything:
> make rebuild
Clean everything:
> make destroy
