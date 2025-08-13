# Store Panel Orchestration
A simple docker orchestration for a LAMP environment.

## PreRequisites

* git
* ssh
* docker
* Your favorite IDE (Visual Studio Code, PhpStorm, etc.)
* My Store Panel repo successfully cloned and running. (https://github.com/wayoxmedia/mystorepanel)
* All Templates (currently 7) + web-templates repos successfully cloned and running.
  * (https://github.com/wayoxmedia/template1)
  * (https://github.com/wayoxmedia/template2)
  * ...
  * (https://github.com/wayoxmedia/template7)
  * (https://github.com/wayoxmedia/web-templates)

## Installation

### Folder Structure

You should have already a folder structure like this:

    YourDevFolder
    |- template1
    |- template2
    |- template3
    |- template4
    |- template5
    |- template6
    |- template7
    |- web-templates
    |- orchestration     <- This repo
    |- mystorepanel

### Getting Started

You must have Docker installed and running properly.

clone this repo using git

`git clone git@github.com:wayoxmedia/orchestration.git`

cd into your app

`cd orchestration`

run docker build

`docker compose build`

this may take some minutes if this is your first install, images are been downloaded.

Now, bring up the environment. We have two ways to do this, all of them or the ones you need.

If you want to run all the containers, run:

`docker-compose up -d`

Check that your containers are properly up and running.

`docker ps`

### Troubleshoot

No issues discovered so far, but if you have any, please open an issue.

#### That's it! Welcome to your docker LAMP Environment.

### Recommendations

* Use Visual Studio Code with the Remote - Containers extension to open your project in a container.
* Use the Docker extension to manage your containers, images, volumes, networks and containers.

### Useful commands
* To stop all containers: `docker-compose down`
* To stop and remove all containers, networks, images, and volumes: `docker-compose down --volumes --remove-orphans`
* To rebuild the containers: `docker-compose up -d --build`
* To view logs: `docker-compose logs -f`

#### For debugging purposes

* Global:
  * Edit orchestration/.env → `XDEBUG_LOG_LEVEL=7` to get all logs, or any other level you want (down to 0).
  * Use `docker compose up -d` and then `docker exec -it multi-vhost-apache apachectl -k graceful` (preferred method)
  * Alternatively to above, `docker compose up -d` or `docker compose restart web` to restart the web container.
  * Use `docker exec -it multi-vhost-apache php -i | grep -i xdebug` to check xdebug settings.

Happy coding!

