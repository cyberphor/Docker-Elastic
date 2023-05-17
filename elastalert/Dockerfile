# Dockerfile metadata
FROM python:3.9
LABEL Author="Victor Fernandez III, @cyberphor"

# Install ElastAlert
WORKDIR /opt/elastalert/
ENV PATH=/opt/elastalert:$PATH
RUN python -m venv /opt/elastalert/ &&\
    pip install elasticsearch elastalert2 

# Copy ElastAlert configuration files and rules
COPY entrypoint.sh /opt/elastalert/
COPY elastalert.yml /opt/elastalert/config/
COPY rules/ /opt/elastalert/rules/
COPY whitelist/ /opt/elastalert/whitelist/

CMD [ "entrypoint.sh" ]