# Dockerfile metadata
FROM kibana:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Kibana configuration files
COPY . .

# Set the Kibana service account password and start Kibana
CMD curl -X POST ${ELASTICSEARCH_HOSTS}/_security/user/$KIBANA_USERNAME/_password \
    --cacert ${ELASTICSEARCH_SSL_CERTIFICATEAUTHORITIES} \
    -u "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" \
    -H "Content-Type: application/json" \
    -d '{"password": "$KIBANA_PASSWORD"}' \
    -s -o /dev/null &&\
    echo "Set Kibana password to ${KIBANA_PASSWORD}" &&\
    /usr/local/bin/kibana-docker