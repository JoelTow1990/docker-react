# Production dockerfile
FROM node:16-alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

# We can start a new image and just copy what we need from previous build
# This lets us have leaner production server(s) as we ditch useless files 
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default CMD for nginx is to start nginx so no need to specify