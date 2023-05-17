#!/usr/bin/env bash

CERTS=(
    "/opt/elastalert/config/certs/ca.crt"
    "/opt/elastalert/config/certs/elastalert.crt"
    "/opt/elastalert/config/certs/elastalert.key"
)

for CERT in "${CERTS[@]}"; do
    if [ ! -f $CERT ]; then
        echo "File not found: $CERT"
        exit 1
    else
        echo "File found: $CERT"
    fi
done

# Create an Elasticsearch index and then run ElastAlert
elastalert-create-index --config config/elastalert.yml &&\
elastalert-creare-index --index docker &&\
python -m elastalert.elastalert --config config/elastalert.yml