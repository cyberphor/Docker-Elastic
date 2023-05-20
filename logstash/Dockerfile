FROM logstash:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

USER root
ENV PATH=/opt/logstash/bin:$PATH
WORKDIR /opt/logstash/
COPY config/logstash.yml /opt/logstash/config/

USER logstash
CMD [ "logstash" ]