# Introduction
This project we were assigned required us to work using Vagrant, Ansible, Docker and Jenkins. The exercise is the following:
## Getting Started
- Use Vagrant to create a Rocky Linux 9 VM.
- Automate Docker's installation using Ansible.
- Install Jenkins (master only) using Ansible. So that Ansible uses Docker to install Jenkins.
- Create a Flask (Python) Dockerfile app that prints "Hello World".
- Create a Jenkins declarative pipeline which will make a build using a Docker image that will push on it's own DockerHub account. The Jenkins pipeline need to be called `flask-app-example-build`. The Docker image tag needs to be the same `git tag` if "built" from git tag, `latest` if "built" from branch master, `develop + sha comit GIT` if "built" from branch develop.


> [!NOTE]
> In this folder there are files we created while working on a Kubernetes (k8s) project. You will find Ansible files (playbook.yml, ansible.cfg, inventory), Vagrant files (Vagrantfile)

> [!IMPORTANT]
> NEEDS TO BE COMPLETED
