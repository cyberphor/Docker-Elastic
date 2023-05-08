#!/usr/bin/env bash

if [ ! -f config/certs/instances.yml ]
then
  echo "[x] Input file for elasticsearch-certutil does not exist."
  pwd
  ls config/certs/
  exit 1
else
  echo "[+] Input file for elasticsearch-certutil exists."
fi

if [ ! -f config/certs/ca.zip ]
then
  echo "[*] Creating CA certificates."
  bin/elasticsearch-certutil ca --silent --pem -out config/certs/ca.zip
  unzip config/certs/ca.zip -d config/certs
else
  echo "[+] CA certificates already exist."
fi

if [ ! -f config/certs/certs.zip ]
then
  echo "[*] Creating X.509 certificates for Elasticsearch."
  bin/elasticsearch-certutil cert --silent --pem --in config/certs/instances.yml --ca-cert config/certs/ca/ca.crt --ca-key config/certs/ca/ca.key -out config/certs/certs.zip
  unzip config/certs/certs.zip -d config/certs
else
  echo "[+] X.509 certificates for Elasticsearch already exist."
fi

echo "Setting file permissions"
chown -R root:root config/certs
find . -type d -exec chmod 750 \{\} \;
find . -type f -exec chmod 640 \{\} \;

echo "Waiting for Elasticsearch availability"
until curl -s --cacert config/certs/ca/ca.crt https://elasticsearch:9200 | grep -q "missing authentication credentials"
  do sleep 30
done

echo "Setting kibana_system password"
until curl -s -X POST --cacert config/certs/ca/ca.crt -u "elastic:${ELASTIC_PASSWORD}" -H "Content-Type: application/json" https://elasticsearch:9200/_security/user/kibana_system/_password -d "{\"password\":\"${KIBANA_PASSWORD}\"}" | grep -q "^{}"
  do sleep 10
done

echo "Done!"