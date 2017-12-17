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
1. Modify `.env` to fit the particulars of your setup. Use absolute file paths.
2. Modify `docker-compose.yml`; replacing `example.com` and `othersite.com` with your own URLs.
3. Modify `nginx/vhosts/example.com` and replace occurences of `example.com` with your URLs.

**File locations**
You can place your web sites in any directory on your server that you wish. If you chose a directory other than /sites/example.com, be sure to update the references in your .env file to point to the appropriate directory.

Launch the containers with `docker-compose up -d`. This runs Docker in detached mode. You'll see a message that your containers have launched, but you will not see continuous logs on your screen.

Open a new web browser and pull up your domain name. If it doesn't appear, check the Nginx logs to see what went wrong.

### Logs
Nginx logs are written to `logs/nginx/access.log` and `logs/nginx/error.log`

To view the logs for other services, type `sudo journalctl <service name>`

## Certbot
Once the non-SSL version of your site appears, it's time to generate the SSL certificate with Let's Encrypt.

Log into certbot with `docker exit -it certbot bash`

Then, run:

`./certbot-auto certonly --email youremail@example.com --webroot -w /www -d domain.com -d www.domain.com -d otherdomain.com`

Please replace the domains in the string above with your own values. Certbot will then update itself and attempt to validate your domain. Once it does, you can add the SSL-specific segments to your vhost files.

## Adding SSL to Nginx Configuration

1. Navigate to `vhosts.secure/example.com`
2. Copy the second server block and paste it into your existing `vhosts/example.com` file. Replace all instances of example.com with your own domain name.
3. Restart nginx: `sudo systemctl restart nginx`
4. Attempt to access the secure version of your domain name.

You can check the quality of your setup by verifying it at the [https://www.ssllabs.com/ssltest/](SSL Labs) web site.