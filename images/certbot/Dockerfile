FROM ubuntu:16.04

LABEL maintainer="https://github.com/kaizen-soze"

# The add command expects a file named 'crontab' to be present
# in the same directory as your dockerfile

ADD crontab /etc/cron.d/certbot-cron
RUN chmod 0644 /etc/cron.d/certbot-cron
RUN touch /var/log/cron.log

RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install cron

RUN ls
RUN wget https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto
RUN ./certbot-auto --os-packages-only -n

CMD cron && tail -f /var/log/cron.log