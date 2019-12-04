FROM ubuntu:bionic
ENV HOST_KEY="ssh key"
RUN apt-get update && apt install -y openjdk-8-jdk
RUN apt-get install -y wget \
&& apt-get install -y gnupg
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update \
&& apt-get install -y jenkins
RUN apt-get install -y openssh-server
RUN mkdir ~/.ssh
RUN mkdir /var/lib/jenkins/.ssh
RUN ssh-keygen -t rsa -N "" -f /var/lib/jenkins/.ssh/id_rsa
RUN chown -R jenkins:jenkins  /var/lib/jenkins/.ssh/*
RUN apt-get install -y git
VOLUME /var/lib/jenkins/
WORKDIR /var/lib/jenkins/
EXPOSE 8080
EXPOSE 50000
EXPOSE 22
ENTRYPOINT service jenkins start \
&& echo ${HOST_KEY} > ~/.ssh/authorized_keys \
&& service ssh start \
&& /bin/bash
