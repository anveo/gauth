FROM alpine

RUN apk add --update bash ca-certificates && \
    rm -rf /var/cache/apk/* /tmp/*

RUN update-ca-certificates

ENV BIN_DIR /opt/app
RUN mkdir -p ${BIN_DIR}
WORKDIR ${BIN_DIR}

ENV CONFIG_DIR /root/.config
VOLUME ${CONFIG_DIR}
RUN mkdir -p ${CONFIG_DIR}
COPY gauth.csv ${CONFIG_DIR}/gauth.csv

COPY ./bin/gauth ${BIN_DIR}/gauth

COPY docker-entrypoint.sh /usr/local/bin
RUN ln -s /usr/local/bin/docker-entrypoint.sh ./entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["./gauth"]