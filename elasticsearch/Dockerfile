FROM elasticsearch:8.7.1

LABEL Author="Victor Fernandez III, @cyberphor"

COPY elasticsearch.yml /usr/share/elasticsearch/config/

# TODO: cp http_ca.crt /usr/share/elasticsearch/config/certs/http_ca.crt
# TODO: /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

CMD [ "elasticsearch" ]