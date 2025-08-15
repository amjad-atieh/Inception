FROM alpine:3.21

RUN  apk update && apk add nginx openssl && rm -rf /var/cache/apk/* \
	&& mkdir -p /etc/certs && openssl req -x509 -newkey rsa:2048 -nodes \
  	-keyout /etc/certs/server.key -out /etc/certs/server.crt -days 365 \
  	-subj "/CN=localhost"
	
COPY default.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
