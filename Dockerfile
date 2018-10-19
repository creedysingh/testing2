# purpose of adding as builder is know we are in builder phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install

# we are directly coping as we are not in dev mode now
COPY . .
RUN npm run build

## Second Phase is to run nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html