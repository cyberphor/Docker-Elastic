FROM elasticsearch:8.7.1

LABEL Author="Victor Fernandez III, @cyberphor"

USER root

WORKDIR /opt/elasticsearch/

RUN sed -i 's/usr\/share\/elasticsearch/opt\/elasticsearch/g' /usr/local/bin/docker-entrypoint.sh && \
    export PATH=/opt/elasticsearch/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin && \
    mv /usr/share/elasticsearch/* /opt/elasticsearch/

COPY elasticsearch.yml /usr/share/elasticsearch/config/

CMD [ "elasticsearch" ]