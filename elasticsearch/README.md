# Elasticsearch

**Step 1.** Build and tag an image of Elasticsearch.
```bash
# -t: tag (e.g., registry/app:version)
# -f: file-path to Dockerfile
# .: use the current working directory as the build context (i.e., build from here)
docker build -t local/elasticsearch:latest -f Dockerfile . 
```

**Step 2.** Start a container using the image. 
```bash
# -n: name
# -m: memory size
# -d: daemon mode
# -P: expose ports mentioned in Dockerfile
docker run --name elasticsearch -m 1GB -d -P -t local/elasticsearch:latest
```

**Step 3.** Stop and remove the container. 
```bash
docker rm elasticsearch
```

**Step 4.** Remove the image. 
```bash
docker rmi local/elasticsearch:latest
```