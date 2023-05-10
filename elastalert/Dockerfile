FROM python:3.9

LABEL Author="Victor Fernandez III, @cyberphor"

RUN pip install elasticsearch elastalert2 && \
    mkdir /opt/elastalert && \
    mv /usr/local/bin/elastalert* /opt/elastalert

COPY rules /opt/elastalert/rules

COPY elastalert.yml /opt/elastalert

CMD [ "python", "-m", "elastalert.elastalert", "--config", "/opt/elastalert/elastalert.yml" ]
