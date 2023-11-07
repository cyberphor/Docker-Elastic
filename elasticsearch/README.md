# Elasticsearch

**Step 1.** Build an image of Elasticsearch.
```bash
# -t: tag the image (e.g., registry/app:version)
# -f: path to Dockerfile
# .: use the current working directory as the build context (i.e., build from here)
docker image build -t local/elasticsearch:latest -f Dockerfile  . 
```

**Step 2.** Create a volume for the container.
```bash
docker volume create certs
```

**Step 3.** Create a network.
```bash
docker network create elastic
```

**Step 2.** Create the container using the image. 
```bash
# --name: container name (to reference when starting and stopping it) 
# -m: memory to allocate to the container
# -p: ports to expose (host:container)
# --env-file: path to file where environment variables are defined
docker container create --name elasticsearch --env-file .env -v certs:/usr/share/elasticsearch/config/certs/ -p 9200:9200 --network elastic local/elasticsearch:latest
```

**Step 3** Inspect the container and verify it was configured correctly. 
```bash
docker container inspect elasticsearch
```

**Step 4.** Start the container in the background.
```bash
docker container start elasticsearch
```

**Step 5.** Stop the container. 
```bash
docker container stop elasticsearch
```

**Step 6.** Remove the container. 
```bash
docker container rm elasticsearch
```

**Step 7.** Remove the image. 
```bash
docker image rm local/elasticsearch:latest
```

**Step 8.** Remove the volume.
```bash
# text goes here
```