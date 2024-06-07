
FROM jenkins/jenkins:lts-jdk17

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

ENV JENKINS_ADMIN_ID admin
ENV JENKINS_ADMIN_PASSWORD admin

USER root

RUN apt update -qq && apt install docker.io -y
RUN usermod -aG docker jenkins

COPY --chown=jenkins:jenkins casc.yaml /var/jenkins_home/casc.yaml
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

USER jenkins
