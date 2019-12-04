FROM jenkins/ssh-slave
RUN apt-get update && apt install maven -y \
&& apt-get install openjdk-8-jdk -y \
&& apt-get install -y jq \
&& apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
COPY --chown=jenkins:jenkins settings.xml /home/jenkins/.m2/settings.xml
