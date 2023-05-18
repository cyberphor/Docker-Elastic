#!/usr/bin/env bash

CERTS=(
    "/opt/elastalert/config/certs/ca.crt"
    "/opt/elastalert/config/certs/elastalert.crt"
    "/opt/elastalert/config/certs/elastalert.key"
)
CUSTOM_INDEX="logstash"
WRITEBACK_INDEX="elastalert_status"

for CERT in "${CERTS[@]}"; do
    if [ ! -f $CERT ]; then
        echo "File not found: $CERT"
        exit 1
    else
        echo "File found: $CERT"
    fi
done

CUSTOM_INDEX_CHECK=$(curl --cacert config/certs/ca.crt -u elastic:elastic -s -o /dev/null -w "%{http_code}" -X GET -H "Content-Type: application/json" "https://172.16.0.10:9200/$CUSTOM_INDEX")
if [ "$CUSTOM_INDEX_CHECK" == "200" ]; then
  echo "Index '$CUSTOM_INDEX' already exists."
else
  CREATE_CUSTOM_INDEX=$(curl --cacert config/certs/ca.crt -u elastic:elastic -s -o /dev/null -w "%{http_code}" -X PUT -H "Content-Type: application/json" "https://172.16.0.10:9200/$CUSTOM_INDEX")
  if [ "$CREATE_CUSTOM_INDEX" == "200" ]; then
    echo "Created the '$CUSTOM_INDEX' index."
  else
    echo "Failed to create '$CUSTOM_INDEX' index."
    exit 1
  fi
fi

WRITEBACK_INDEX_CHECK=$(curl --cacert config/certs/ca.crt -u elastic:elastic -s -o /dev/null -w "%{http_code}" -X GET -H "Content-Type: application/json" "https://172.16.0.10:9200/$WRITEBACK_INDEX")
if [ "$WRITEBACK_INDEX_CHECK" == "200" ]; then
  echo "Index '$WRITEBACK_INDEX' already exists."
else
  elastalert-create-index --config config/elastalert.yml
fi

# Run ElastAlert
python -m elastalert.elastalert --config config/elastalert.yml