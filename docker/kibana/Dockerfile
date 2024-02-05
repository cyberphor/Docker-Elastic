# Dockerfile metadata
FROM kibana:8.12.0
LABEL Author="Victor Fernandez III, @cyberphor"

CMD curl -X POST https://elasticsearch:9200/_security/user/kibana_system/_password \
    --cacert config/certs/ca.crt \
    -u "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" \
    -H "Content-Type: application/json" \
    -d '{"password":"${KIBANA_PASSWORD}"}' \
    -s &&\
    /usr/local/bin/kibana-docker