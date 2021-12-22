#STEP 1 BUILD VUE PROJECT
FROM node:12.18.1-alpine AS BUILD
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

#STEP 2 CREATE NGINX SERVER
FROM nginx:1.19.0-alpine AS prod-stage
COPY --from=BUILD /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

