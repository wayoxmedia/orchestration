# Store Admin Orchestration
A simple docker orchestration for a LAMP environment.

## PreRequisites

* git
* ssh
* docker
* Your favorite IDE (Visual Studio Code, PhpStorm, etc.)
* My Store Panel repo successfully cloned and running. (https://github.com/wayoxmedia/myStorePanel)
* All Templates (currently 7) repos successfully cloned and running.
  * (https://github.com/wayoxmedia/template1)
  * (https://github.com/wayoxmedia/template2)
  * ...
  * (https://github.com/wayoxmedia/template7)

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

Now, bring up the environment.

`docker-compose up -d`

Check the containers are properly running

`docker ps`

### Troubleshoot

No issues discovered so far, but if you have any, please open an issue.

#### That's it! Welcome to your docker LAMP Environment.

### Recommendations

* Use Visual Studio Code with the Remote - Containers extension to open your project in a container.
* Use the Docker extension to manage your containers, images, volumes, networks and containers.


Happy coding!

