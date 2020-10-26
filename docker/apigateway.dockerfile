FROM node:14

WORKDIR /var/www

RUN npm install

EXPOSE 3000
CMD npm start
