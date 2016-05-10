FROM ubuntu:14.04

# so this will eventually hold all sorts of repos/ppas/packages
# just so i dont have multiple versions of ubuntu rolling around
# on my hard drive

# a little design discussion:
# /app is where you might install app-specific stuff that you want to persist in the image
# USER is set to $USER on the host system and has the same id as on the host, to expand:
#   - the image will have a user called 'user' with the same id as the user on the host
#     (hard coded to 1000 at the moment because debian)
#   - mymount will mount $PWD to /home/user
#     which means that any files written will be written to the host system and all the
#     permissions will be fine
#   - yes, 'fine' is currently defined as 'easy to use but think of the securities!'

RUN echo forcing a damn update
RUN apt-get update

RUN apt-get install -y curl unzip software-properties-common locate wget
RUN apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev
RUN mkdir -p /app
RUN apt-get update
RUN updatedb

# if your image needs keys on it, this is how to get them in
# this means that even though you cant docker push the images
# i can at least git push these dockerfiles
COPY user-ssh.tgz /app/user-ssh.tgz

# i wish we could pass `id -un` here to get username from host
# and `id -u`
# or even $USER and $UID
# maybe play with:
#  cat Dockerfile | envsubst | docker build
#  or
#  cat Dockerfile | envsubst > temp-dockerfile .... docker build temp-dockerfile
run echo sdfsdfsdfsdfsdf
RUN mkdir -p /local_libraries
RUN useradd -m -u 1000 -s /bin/bash appuser
RUN chown -R appuser:appuser /app
RUN chown appuser:appuser /var/log
RUN chown -R appuser:appuser /local_libraries

#RUN echo 'appuser     ALL=(ALL:ALL) ALL' >> /etc/sudoers
RUN echo 'appuser ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

USER appuser

# if you are running this on a mounted git repo (the common use case) then you should
# really have .ssh* in your global .gitignore
RUN echo '#!/bin/bash \n tar -zxf /app/user-ssh.tgz -C /home/appuser \n' > /app/user-setup
RUN chmod +x /app/user-setup

# because the main reason for appuser is to mount over the home directory
WORKDIR /app


