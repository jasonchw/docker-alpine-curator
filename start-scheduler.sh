#!/bin/bash

if [ "${ELASTICSEARCH_URL}" ]; then
    sed -i -e "s#elasticsearch:9200#${ELASTICSEARCH_URL}#" /etc/curator/curator.yml
fi

exec crond -f -L /var/log/crond.log


