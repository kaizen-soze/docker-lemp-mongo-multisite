server {
        listen [::]:80;
        listen 80;

        server_name othersite.com www.othersite.com;

        root /var/www/othersite.com/public_html;
        index index.php;

        location ~ /.well-known {
           root /var/www/;
           default_type "text/plain";
           allow all;
           autoindex on;
        }

        # Deny access to hidden files
        location ~ /\. {
            access_log off;
            log_not_found off; 
            deny all;
        }

        location / {
            try_files $uri/ /index.php?$args;
        }

        # Pass PHP scripts to PHP-FPM
        location ~* \.php$ {
            fastcgi_index   index.php;
            fastcgi_pass    fpm:9000;

            include         fastcgi_params;
            fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
            fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
        }
    }

    server {
      listen 443 ssl http2;
      
      server_name othersite.com www.othersite.com;

      ssl_certificate /etc/letsencrypt/live/othersite.com/fullchain.pem; 
      ssl_certificate_key /etc/letsencrypt/live/othersite.com/privkey.pem;
      ssl_session_timeout 1d;
      ssl_session_cache shared:SSL:50m;
      ssl_session_tickets off;
      ssl_protocols TLSv1.1 TLSv1.2;
      ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!3DES:!MD5:!PSK';
      ssl_prefer_server_ciphers on;
      
      # https://security.stackexchange.com/questions/70831/does-dh-parameter-file-need-to-be-unique-per-private-key
      ssl_dhparam /etc/nginx/certs/dhparam.pem; 
      
      add_header Strict-Transport-Security max-age=15768000;
      ssl_stapling on;
      ssl_stapling_verify on;
      ssl_trusted_certificate /etc/letsencrypt/live/othersite.com/chain.pem; 
      resolver 8.8.8.8 8.8.4.4 valid=86400;
      
      root /var/www/othersite.com/public_html;
      index index.php;
      
      location / {
        try_files $uri $uri/ /index.php?$args;
      }        
      location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }
          root           /var/www/othersite.com/public_html;
          fastcgi_pass   fpm:9000;
          fastcgi_index  index.php;
          fastcgi_param SCRIPT_FILENAME /var/www/othersite.com/public_html$fastcgi_script_name;
          include        fastcgi_params;
      }    
    }