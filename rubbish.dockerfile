FROM oki/ubuntu-td


RUN echo 'hello there'

CMD cat /etc/resolv.conf
