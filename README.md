# My Store Panel Orchestration
A simple docker orchestration for a LAMP environment.

## PreRequisites

* git
* ssh
* docker
* Your favorite IDE (Visual Studio Code, PhpStorm, etc.)
* My Store Panel repo successfully cloned. (https://github.com/wayoxmedia/mystorepanel)
* All Templates (currently 7) + web-templates repos successfully cloned.
  * (https://github.com/wayoxmedia/template1)
  * (https://github.com/wayoxmedia/template2)
  * ...
  * (https://github.com/wayoxmedia/template7)
  * (https://github.com/wayoxmedia/web-templates)

## Installation

### Folder Structure

You should have already cloned all the repos in a folder structure like this:

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

### Web-Templates and MyStorePanel S2S connections
To connect your web-templates and mystorepanel containers, you need to set some environment variables in the `.env` file located in the both mystorepanel and web-templates `html` directories.

In `web-templates/html/.env` you should have something like this:

```dotenv
BACKEND_BASE_URL=http://mystorepanel.test
BACKEND_SERVICE_TOKEN=replace-with-a-long-random-string
# Line above should match the SERVICE_TOKEN in mystorepanel/html/.env
SITE_RESOLVER_URL=http://mystorepanel.test/api/sites/resolve

BACKEND_API_PREFIX=/api
BACKEND_TIMEOUT=10
BACKEND_CONNECT_TIMEOUT=5
BACKEND_RETRY=1
BACKEND_RETRY_DELAY_MS=150
```

And in `mystorepanel/html/.env` you should have:

```dotenv
SERVICE_TOKEN=replace-with-a-long-random-string
# Line above should match the BACKEND_SERVICE_TOKEN in web-templates/html/.env
RESOLVE_CACHE_TTL=600
PAGES_CACHE_TTL=600
```

Let's replace the `replace-with-a-long-random-string` with a long random string, you can use any of the following commands in your terminal:

```bash
# Option A (OpenSSL, base64 32 bytes ≈ 43 chars)
openssl rand -base64 32

# Option B (OpenSSL, base64 64 bytes ≈ 86 chars)
openssl rand -base64 64

# Option C (hex 64 bytes ≈ 128 chars)
openssl rand -hex 64

# Option D (PHP)
php -r 'echo base64_encode(random_bytes(64)).PHP_EOL;'
```
Update the values in both `.env` files with the generated string. Make sure you use only one of the methods above to generate the string, and that both files have the same value for `SERVICE_TOKEN` and `BACKEND_SERVICE_TOKEN`.

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
* To force recreation of containers, useful when updating .env files or docker-compose: `docker-compose up -d 
--force-recreate`

#### For debugging purposes

* Global:
  * Edit orchestration/.env → `XDEBUG_LOG_LEVEL=7` to get all logs, or any other level you want (down to 0).
  * Use `docker compose up -d` and then `docker exec -it apache apachectl -k graceful` (preferred method)
  * Alternatively to above, `docker compose up -d` or `docker compose restart web` to restart the web container.
  * Use `docker exec -it apache php -i | grep -i xdebug` to check xdebug settings.

Happy coding!

