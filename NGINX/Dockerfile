FROM alpine:3.21

RUN  apk update && apk add nginx && rm -rf /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY my.conf /etc/nginx/http.d/my.conf
COPY index.html /index.html
COPY certs /etc/certs

CMD ["nginx", "-g", "daemon off;"]
