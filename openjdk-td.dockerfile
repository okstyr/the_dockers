FROM oki/ubuntu-td

USER root

RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update

RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN apt-get install -y maven2

RUN updatedb

USER appuser
