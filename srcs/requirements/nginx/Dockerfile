FROM alpine:3.21

COPY certGen.sh /certGen.sh

RUN  apk update && apk add nginx openssl && rm -rf /var/cache/apk/* \
	&& chmod  +x /certGen.sh
	
COPY default.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["/certGen.sh"]
CMD ["nginx", "-g", "daemon off;"]
