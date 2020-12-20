FROM nginx:alpine

COPY ./dist/AngularApp /usr/share/nginx/html
COPY ./.docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80