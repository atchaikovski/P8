FROM nginx
COPY ./index.html /usr/share/nginx/html
#COPY ./md5sum.txt /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx
COPY default.conf /etc/nginx/conf.d
