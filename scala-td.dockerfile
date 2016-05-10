FROM oki/openjdk-td

USER root

RUN curl -o scala-2.11.6.tgz http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz
RUN tar -xzf scala-2.11.6.tgz
RUN echo 'export PATH=/scala-2.11.6/bin:$PATH' >> /root/.bashrc

RUN curl -L -o sbt-0.13.8.deb https://dl.bintray.com/sbt/debian/sbt-0.13.8.deb
RUN dpkg -i sbt-0.13.8.deb

RUN apt-get install sbt

RUN updatedb
RUN chown appuser:appuser /var/log
# we probably need to mount (during docker run) $HOME/.ivy2 to speed up ./sbt
USER appuser
