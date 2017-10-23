server {
        listen [::]:80 default_server;
        listen 80;

        server_name example.com www.example.com;

        root /var/www/example.com/public_html;
        index index.php;

        location ~ /.well-known {
           root /var/www/;
           default_type "text/plain";
           allow all;
           autoindex on;
        }

        # https://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/

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