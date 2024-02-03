# Dockerfile metadata
FROM logstash:8.11.2
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Logstash configuration files and plugins
COPY logstash.yml config/logstash.yml
COPY spiritbox.conf pipeline/spiritbox.conf