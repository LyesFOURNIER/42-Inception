# 42-Inception
*This project has been created as part of the 42 curriculum by lfournie.*
## Description
The "Inception" project serves as an introduction to the service called **Docker**.

It was created back in 2013 as a alternative to virtual machines; you see, virtual machines did their job well, which was to solve the portability issues between different architectures on which developers coded, but they had one major flaw: **their size**.
While a VM could be used to fix this compatibility issue, it came with several huge drawbacks related to their size:
- You had to install an OS to make it run, which takes **several gigabytes of overhead** unrelated to the project at hand;
- It could take **several minutes to boot** depending on the resources allocated;
- Scaling up a project meant more VMs to setup, more OSes to install and even more overhead.

In short, it was **useful but cumbersome**.

Enter **Docker**, a new service which would tackle all the problems the VM was used for but in a better fashion.
Docker uses **Containers**: an executable package of software that includes everything to run an application: code, runtime, system tools, system libraries and settings; in essence, everything a VM offered but with one huge difference, **a lighter standalone frame**.

What does that involve?
- **Less overhead** due to OSes files;
- An environment that, once built, **launches almost instantly**;
- A **better scalability** of projects.

How does containers save weight?

Unlike VMs, which create a virtual kernel, **containers use the kernel of the host machine**, skipping the need for sizable OS's files; no new OS installation is needed.

Docker hasn't invented containers mind you, but it made several huge improvements to their usage:
- It made containers **developer-friendly**;
- It gave developers a **simple CLI**(command-line interface);
- It brought a **layered image system**(which optimize storage space and minimize duplication of data);
- It introduced **Docker Hub** for image sharing.

Thus taking a complicated but useful concept and simplifying it, in addition to making it shareable, creating an active community around them.

Now what does the "Inception" subject ask of us?
As an introduction to Docker, we are to create a simple Docker network, meaning we are to setup multiple containers and make them communicate between them. The usage of three specific containers is mandatory:
- **Nginx**
- **MariaDB**
- **WordPress**

## Project Description/Architecture
As said previously, this project aims to set up a simple infrastructure using **Docker** and **Docker Compose**.
Each service runs in its own container and communicate through a dedicated Docker network.

The infrastructure includes:
- **Nginx** as a reverse proxy with TLS;
- **MariaDB** as the database;
- **WordPress** with PHP-FPM.

Docker is used to ensure:
- The **isolation** of services;
- The **reproducibility** of the environment;
- The **ease of deployment**.

All services are built from custom Dockerfile (all based on Debian:bookworm).

The following design choices have been taken for this project:
- Each service runs in a **separeate container** (one process per container);
- A **custom Docker network** is used for inter-container communication;
- **Volumes** are stored localy on the host machine to ensure the data persitence of containers;
- Sensitive data are stored in a env file which needs to be filled;
- Nginx is the **only exposed entry point** (port 443).

### A few technical comparisons

#### Virtual Machines vs Docker
| **VMs**                 | **Docker**                      |
|-------------------------|---------------------------------|
| Emulate full OS (heavy) | Share host kernel (lightweight) |
| Slower startup          | Fast startup                    |
| Higher resource usage   | Efficient resource usage        |
| Strong isolation        | Process-level isolation         |

Docker is used because it is **lightweight, faster and better suited for microservices**.

#### Secret vs Environment Variables
| **Secret** | **Environment Variables** |
|---|---|
| Stored securely (not exposed in image/layers) | Visible in container config |
| Mounted as file at runtime | Passed as plain text |
| Safer for passwords and keys | Easier but less secure |

Docker secrets are used for **sensitive** data (DB passwords), while environment variables are used for **non-sensitive** configuration.
I haven't used secrets in this project but an environment file.

#### Docker Network vs Host Network
| **Docker Network** | **Host Network** |
|---|---|
| Isolated internal network | Shares host network |
| Containers communicate via service names | Uses localhost directly |
| Better security and control | Less isolation |

A cutstom Docker network is used to ensure **isolation** and allow containers to communicate using **DNS** (service names).

#### Docker Volumes vs Bind Mounts
| **Docker Volumes** | **Bind Mounts** |
|---|---|
| Managed by Docker | Linked to host filesystem |
| Portable and safer | Depends on host structure |
| Better for production | Useful for development |

Volumes are used for **data persistence** to ensure **portability** and **avoid dependency** on host paths.


## Instructions
### Prerequisites
Make sure you have the following installed:
- **Docker**
- **Docker Compose**

Check installation:
> docker --version

> docker compose version

### Installation
clone the repository:
> git clone <repo-SSH-link> <name-of-cloned-folder>
> cd <name-of-cloned-folder>

### Running the project
Build and start all services:
> make

or
> make up

Just build
> make build

Start all existing containers:
> make start

Stop all existing containers:
> make stop

Stop and remove all existing containers:
> make down

For more available commands:
> make help

### Access
Once running, open:
> https://lfournie.42.fr

or
> https://localhost

## Resources

### Documentation and Learing Materials
The following resources were used to understand and build the project:
- Docker [official documentation](https://docs.docker.com/).
- Docker Compose [documentation](https://docs.docker.com/compose/)
- [Nginx](https://nginx.org/en/docs/), [WordPress](https://wordpress.org/documentation/) and [MariaDB](https://mariadb.com/docs) official documentations.
- [Tutorial](https://tuto.grademe.fr/inception/) for Inception (outdated but serves as a good starting point).

### AI usage
AI tools (such as ChatGPT) were used in the following ways:
- Understand **obscure concepts** in relation to Docker and used containers
- Help debug configuration on a nearly **finished** project
- Help **structuring** the README
- Testing myself against a simulated examinator

AI tools were not used for:
- Building the project **from scrap**
- Explaining every single concept **without** searching for and trying to understand them first.
- Writing the README **from scrap**
