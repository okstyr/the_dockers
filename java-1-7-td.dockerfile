FROM oki/ubuntu-td
USER root

RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
# needed for java
RUN apt-get install -y binutils gsfonts gsfonts-x11 java-common libfontenc1 libfreetype6 libxfont1 wget x11-common xfonts-encodings xfonts-utils

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

RUN apt-get install -y oracle-java7-installer
RUN apt-get install -y oracle-java7-set-default

ENV JAVA_HOME=/usr/lib/jvm/java-7-oracle

USER hostuser
#RUN updatedb
