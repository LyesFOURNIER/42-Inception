# Overview
This project provides a containerized web infrastructure composed of three services:
- **Nginx**: reverse proxy with HTTPS(TLS)
- **WordPress**: Website application (PHP-FPM)
- **MariaDB**: database service

All services are managed with Docker Compose and communicate through a dedicated network

# Starting th Project
To build and start all services:
> make

or
> make up

# Stopping the Project
To stop running containers:
> make stop

To stop and remove containers:
> make down

# Accessing the Website

Once the project is running, open in you browser:
> https://lfournie.42.fr

or
> https://localhost

# Accessing the Admin Panel
WordPress admin panel:
> https://lfournie.42.fr/wp-admin

or
> https://localhost/wp-admin

Log in using the credentials defined in the .env file

# Credentials Management
All credentials are stored in the .env file
That includes:
- Database name
- Database user and password
- WordPress admin username and password

# Checking Services
To list all containers:
> make ps

To view logs:
> make logs

# Troubleshooting
Website not accessible:
- Check containers are running with "make ps"
- Ensure port 443 is not already in use with following sudo command:
> sudo ss -tulpn | grep :443

WordPress not working:
- Verify MariaDB container is running
- Check logs for error

Changes not applied:
- Rebuild the project with:
> make rebuild
