FROM node:14-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN npm install express 
RUN npm install pg 
RUN npm install ejs  

COPY . .

EXPOSE 8000

CMD [ "node", "app.js" ]
