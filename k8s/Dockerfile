
FROM jenkins/jenkins:lts

USER root

RUN apt update -qq && apt install docker.io -y

RUN usermod -aG docker jenkins

RUN apt clean

USER jenkins
