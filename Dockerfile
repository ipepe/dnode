FROM phusion/passenger-nodejs
MAINTAINER docker@ipepe.pl

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN rm /etc/my_init.d/00_regen_ssh_host_keys.sh

ENV PASSENGER_APP_ENV=production

# configure nginx
ADD src/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD src/init_scripts/ /etc/my_init.d/
RUN rm /etc/nginx/sites-enabled/default

# setup app user
RUN mkdir /home/app/webapp && chown app:app /home/app/webapp
RUN rm -f /etc/service/nginx/down

RUN echo "app:Password1" | chpasswd

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
