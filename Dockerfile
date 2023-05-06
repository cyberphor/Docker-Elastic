FROM elastic:8.7.1

LABEL Author="Victor Fernandez III, @cyberphor"

CMD [ "/usr/share/elasticsearch/bin/elasticsearch-reset-password" ]