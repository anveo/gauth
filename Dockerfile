FROM alpine

RUN apk add --update ca-certificates && \
    rm -rf /var/cache/apk/* /tmp/*

RUN update-ca-certificates

RUN mkdir -p /opt/app
WORKDIR /opt/app

ENV CONFIG_DIR /root/.config
RUN mkdir -p ${CONFIG_DIR}
ADD gauth.csv ${CONFIG_DIR}/gauth.csv
RUN chmod 600 ${CONFIG_DIR}/gauth.csv

ENTRYPOINT ["/opt/app/gauth"]
ADD ./bin/gauth /opt/app/gauth
