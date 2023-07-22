FROM node:19-alpine AS builder
COPY . .
RUN npm install
RUN npm run build

FROM nginx:stable-alpine AS nginx
COPY package.json .
COPY --from=builder /dist /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]