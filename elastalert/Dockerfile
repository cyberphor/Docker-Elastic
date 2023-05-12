# Dockerfile metadata
FROM python:3.9
LABEL Author="Victor Fernandez III, @cyberphor"

USER root
WORKDIR /opt/elastalert/
RUN pip install elasticsearch elastalert2 && \
    mv /usr/local/bin/elastalert* /opt/elastalert/

COPY elastalert.yml /opt/elastalert/
COPY rules/ /opt/elastalert/rules/

CMD [ "python", "-m", "elastalert.elastalert", "--config", "elastalert.yml" ]