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