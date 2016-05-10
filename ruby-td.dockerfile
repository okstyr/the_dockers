FROM oki/ubuntu-td:latest
RUN echo flergl

USER root
RUN apt-get update


RUN wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
RUN tar -xzvf chruby-0.3.9.tar.gz
RUN cd chruby-0.3.9/ && make install

RUN echo "source /usr/local/share/chruby/chruby.sh" > /etc/profile.d/chruby.sh

RUN chmod +x /etc/profile
RUN chmod +x /etc/profile.d/*

RUN echo -e " :backtrace: false \n:bulk_threshold: 1000 \n:sources: \n  - http://rubygems.delivery.realestate.com.au \n    - https://rubygems.org/ \n    :update_sources: true \n    :verbose: true" > /etc/gemrc

#USER appuser

RUN wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
RUN tar -xzvf ruby-install-0.6.0.tar.gz
RUN cd ruby-install-0.6.0/ && sudo make install

USER appuser
