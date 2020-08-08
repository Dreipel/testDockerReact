FROM node:14.7.0-buster as react_build
WORKDIR /app

COPY . /app/
RUN npm config set unsafe-perm true
RUN npm install --silent
RUN npm run build

FROM nginx:1.16.0-alpine

COPY --from=react_build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx","-g","deamon off;"]