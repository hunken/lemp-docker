
server {
        listen 80 ;
        root /var/www/html/your-project;
        index index.php;
        server_name your-local-domain.com;
        #access_log /var/logs/nginx/your_local_domain.access.log;
        #error_log /var/logs/nginx/your_local_domain.error.log;

        #PRODUCTION
        location / {
                try_files $uri $uri/ /index.html;
                proxy_read_timeout 300;
        }
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 20;
        client_max_body_size 15m;
        client_body_timeout 60;
        client_header_timeout 60;
        client_body_buffer_size 1K;
        client_header_buffer_size 1k;
        large_client_header_buffers 4 8k;
        send_timeout 60;
        reset_timedout_connection on;
        types_hash_max_size 2048;
        server_tokens off;
        port_in_redirect off;
        rewrite_log on;

        gzip on;
        gzip_disable "msie6";
        gzip_vary on;
        gzip_proxied any;
        gzip_comp_level 5;
        gzip_buffers 16 8k;
        gzip_types text/plain text/css application/json application/x-javascript text/xml pplication/xml application/xml+rss text/javascript image/png image/gif image/jpeg;

        location ~* \favicon.ico$ {
            access_log off;
            expires 7d;
            add_header Cache-Control public;
        }
        location ~ ^/(img|cjs|ccss|css|js)/ {
            access_log off;
            expires 7d;
            add_header Cache-Control public;
        }
}
