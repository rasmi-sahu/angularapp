FROM node:10.13.0 as node

WORKDIR /app
COPY . .
RUN apt update
RUN apt-get -y install curl
#RUN apt install build-essential apt-transport-https lsb-release ca-certificates curl
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt install nodejs
#install packages
# you can change the version of angular CLI to the one you are using in your application
RUN npm install -g @angular/cli

# if you have libraries in your workspace that the angular app relies on, build them here
#RUN ng build library-name --prod
# build your application
RUN ng build --prod

# STAGE 2
# Deploy APP
# In this stage, we are going to take the build artefacts from stage one and build a deployment docker image
# We are using nginx:alpine as the base image of our deployment image

FROM nginx:alpine

COPY --from=node /app/dist/angularapp /usr/share/nginx/html
COPY --from=node /app/.docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80