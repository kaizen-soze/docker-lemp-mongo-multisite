# Docker: Host Multiple SSL-Enabled LEMP Sites

Docker is great for linking together multiple technologies, but some aspects of it are not terribly obvious.

One such use case is when you want to host multiple PHP sites on the same server.

This repo lets you set up a LEMP stack with a few extra bells and whistles.

In case you're unfamiliar with the term LEMP, it's an awful acronym for:

* Linux
* Nginx (which is pronounce "Engine-X"...so this is really stretching)
* Mariadb
* PHP

This repo also features MongoDB and Certbot.

## Getting started
Modify `.env` to fit the particulars of your setup.

Modify `docker-compose.yml`; replacing `example.com` and `othersite.com` with your own URLs.

Modify `nginx/vhosts/example.com` and replace occurences of `example.com` with your URLs.

Remove `example.com.ssl` and `othersite.com.ssl`. Their presence will only confuse nginx as it tries to load.

Launch the containers with `docker-compose up -d`. This runs Docker in detached mode. You'll see a message that your containers have launched, but you will not see continuous logs on your screen.

## Logs
Logs are written to `logs/nginx/access.log` and `logs/nginx/error.log`



## Certbot

Log into certbot with `docker exit -it certbot bash`

Then, run

`./certbot-auto certonly --email youremail@example.com --webroot -w /www -d domain.com -d www.domain.com -d otherdomain.com`
