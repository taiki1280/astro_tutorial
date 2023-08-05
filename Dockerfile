FROM node:alpine as build-stage

# frontendのソースをビルド
WORKDIR /var/www/
ADD ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx as production-stage

RUN mkdir -p /var/www

COPY --from=build-stage /var/www/dist /usr/share/nginx/html
