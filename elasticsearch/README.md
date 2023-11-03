# Elasticsearch

**Step 1.** Build and tag an image of Elasticsearch.
```bash
# -t: tag (e.g., org/program:version)
# -f: file-path to Dockerfile
# .: use the current working directory as the build context (e.g., build from here)
docker build -t elastic/elasticsearch:latest -f Dockerfile .
```

**Step 2.** Start a container using the image. 
```bash
# -d: daemon mode
# -P: expose ports mentioned in Dockerfile
docker run --name elasticsearch -d -P -t elastic/elasticsearch:latest
```

**Step 3.** Stop and rm the container. 
```bash
docker rm elasticsearch
```