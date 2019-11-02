FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build has the output

# using a new FROM starts a new step
FROM nginx
EXPOSE 80

# taken from image documentation
COPY --from=builder /app/build /usr/share/nginx/html
