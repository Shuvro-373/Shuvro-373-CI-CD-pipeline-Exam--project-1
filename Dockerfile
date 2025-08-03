#Dockerfile
FROM node:12.2.0-slim
WORKDIR app
COPY . .
RUN npm install

EXPOSE 8000
CMD ["node","app.js"]
