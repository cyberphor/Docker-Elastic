# Dockerfile metadata
FROM elasticsearch:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

# Change the path for Elasticsearch from /usr/share to /opt 
USER root
ENV PATH=/opt/elasticsearch/bin:$PATH
WORKDIR /opt/elasticsearch/
RUN mv /usr/share/elasticsearch/* /opt/elasticsearch/ &&\
    sed -i 's/usr\/share\/elasticsearch/opt\/elasticsearch/g' /etc/ca-certificates/update.d/docker-openjdk &&\
    sed -i 's/usr\/share\/elasticsearch/opt\/elasticsearch/g' /usr/local/bin/docker-entrypoint.sh &&\
    sed -i 's/usr\/share\/elasticsearch/opt\/elasticsearch/g' /etc/passwd

# Copy an "elasticsearch-certutil" input file
COPY elasticsearch.yml /opt/elasticsearch/config/
COPY instances.yml /opt/elasticsearch/config/certs/

# Generate a CA certificate (needed to sign X.509 certificates)
RUN elasticsearch-certutil ca --silent --pem \
    --out config/certs/ca.zip &&\
    unzip config/certs/ca.zip -d config/certs 

# Generate X.509 certificates for mutual authentication between Elasticsearch, Logstash, Kibana, and Elastalert
RUN elasticsearch-certutil cert --silent --pem \
    --in config/certs/instances.yml \
    --ca-cert config/certs/ca/ca.crt \
    --ca-key config/certs/ca/ca.key \
    --out config/certs/elastic.zip &&\
    unzip config/certs/elastic.zip -d config/certs 

# Reorganize and restrict Elasticsearch files
RUN mv config/certs/*/* config/certs/ &&\
    rm -r config/certs/*/ config/certs/*.zip config/certs/instances.yml

# Run Elasticsearch
USER elasticsearch
CMD [ "elasticsearch" ]