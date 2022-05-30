FROM nginx:1.21.6-alpine
EXPOSE 80

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]
