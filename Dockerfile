FROM jasonchw/alpine-consul:0.7.0

ARG CURATOR_VER=4.2.6
ARG SCHEDULER_DIR=/etc/periodic/daily

RUN apk update && apk upgrade && \
    apk add py-pip && \
    pip install --upgrade pip && \
    pip install -U elasticsearch-curator==${CURATOR_VER} && \
    rm -rf /var/cache/apk/* && \
    rm /etc/consul.d/consul-ui.json && \
    mkdir -p /var/log/curator

COPY etc/consul.d/curator.json /etc/consul.d/

# do not put file extensions on script name, otherwise it will not run
COPY run-curator  ${SCHEDULER_DIR}/run-curator

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY start-scheduler.sh   /usr/local/bin/start-scheduler.sh
COPY healthcheck.sh       /usr/local/bin/healthcheck.sh

RUN chmod +x ${SCHEDULER_DIR}/run-curator && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/start-scheduler.sh && \
    chmod +x /usr/local/bin/healthcheck.sh

ENTRYPOINT ["docker-entrypoint.sh"]

HEALTHCHECK --interval=2s --timeout=2s --retries=30 CMD /usr/local/bin/healthcheck.sh

