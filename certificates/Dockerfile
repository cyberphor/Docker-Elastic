FROM elasticsearch:8.7.1

LABEL Author="Victor Fernandez III, @cyberphor"

USER root

WORKDIR /opt/elasticsearch/

RUN sed -i 's/usr\/share\/elasticsearch/opt\/elasticsearch/g' /usr/local/bin/docker-entrypoint.sh && \
    mkdir /opt/elasticsearch && \
    mv /usr/share/elasticsearch/* /opt/elasticsearch/

COPY instances.yml /opt/elasticsearch/config/certs/instances.yml

COPY setup.sh /opt/elasticsearch/bin/

CMD [ "bash", "bin/setup.sh" ]