#Dockerfile
FROM node:20 AS builder
WORKDIR app
COPY . .
RUN npm install

EXPOSE 8000
CMD ["node","app.js"]
