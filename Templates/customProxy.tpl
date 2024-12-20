# READ README.md FILE BELOW THIS FILE AND CHANGE THIS FILE ACCORDING TO YOUR DOMAIN AND PORT INFO

server {
    listen 31.210.43.49:80;
    server_name umutsar.net www.umutsar.net;
    error_log /var/log/nginx/umutsar.net.error.log error;

    include /home/web_admin/conf/web/umutsar.net/nginx.forcessl.conf*;

    location ~ /\.(?!well-known\/|file) {
        deny all;
        return 404;
    }

    location / {
        proxy_pass http://31.210.43.49:3004;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location ~* \.(css|htm|html|js|json|xml|apng|avif|bmp|cur|gif|ico|jfif|jpg|jpeg|pjp|pjpeg|png|svg|tif|tiff|webp|aac|caf|flac|m4a|midi|mp3|mp4|ogg|webm|woff|woff2|ttf|eot|otf|svgz|ttf|woff2|zip|rar)$ {
        root /home/web_admin/web/umutsar.net/public_html;
        try_files $uri @fallback;
        access_log /var/log/apache2/domains/umutsar.net.log combined;
        access_log /var/log/apache2/domains/umutsar.net.bytes bytes;
        expires max;
    }

    location @fallback {
        proxy_pass http://31.210.43.49:3004;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location /error/ {
        alias /home/web_admin/web/umutsar.net/document_errors/;
    }

    disable_symlinks if_not_owner from=/home/web_admin/web/umutsar.net/public_html;

    include /home/web_admin/conf/web/umutsar.net/nginx.conf_*;
}
