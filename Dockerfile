FROM phusion/passenger-nodejs
MAINTAINER docker@ipepe.pl

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN rm /etc/my_init.d/00_regen_ssh_host_keys.sh

ENV PASSENGER_APP_ENV=staging

# configure nginx
ADD src/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD src/init_scripts/ /etc/my_init.d/
RUN rm /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down

# setup app user
RUN mkdir /home/app/webapp && chown app:app /home/app/webapp
RUN echo "app:Password1" | chpasswd

# install additional packages
RUN apt-get install -y nano

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
