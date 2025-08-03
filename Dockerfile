#Dockerfile
FROM node:24-alpine
WORKDIR app
COPY . .
RUN npm install

EXPOSE 8000
CMD ["node","app.js"]
