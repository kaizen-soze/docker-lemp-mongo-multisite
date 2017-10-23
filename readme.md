## Certbot

Log into certbot with `docker exit -it certbot bash`

Then, run

`./certbot-auto certonly --email youremail@example.com --webroot -w /www -d domain.com -d www.domain.com -d otherdomain.com`
