FROM elasticsearch:8.7.1

LABEL Author="Victor Fernandez III, @cyberphor"

COPY setup.sh /usr/share/elasticsearch/bin/

COPY instances.yml /usr/share/elasticsearch/config/certs/instances.yml

CMD [ "bash", "/usr/share/elasticsearch/bin/setup.sh" ]