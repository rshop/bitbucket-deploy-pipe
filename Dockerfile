FROM alpine

WORKDIR /var/www/html
COPY pipe.sh /var/www/html/

RUN apk update && apk add openssh-client bash \
    && chmod +x /var/www/html/pipe.sh

ENTRYPOINT ["/var/www/html/pipe.sh"]