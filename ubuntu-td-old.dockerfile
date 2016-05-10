FROM ubuntu:14.04

# so this will eventually hold all sorts of repos/ppas/packages
# just so i dont have multiple versions of ubuntu rolling around
# on my hard drive

RUN echo forcing a damn update
RUN apt-get update

RUN apt-get install -y curl unzip software-properties-common
RUN apt-get install -y locate



RUN mkdir -p /app
RUN apt-get update
RUN updatedb

COPY oki-ssh.tgz /app/oki-ssh.tgz


