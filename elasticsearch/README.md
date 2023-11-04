# Elasticsearch

**Step 1.** Build an image of Elasticsearch.
```bash
# -t: tag (e.g., registry/app:version)
# -f: path to Dockerfile
# .: use the current working directory as the build context (i.e., build from here)
docker build -f Dockerfile -t local/elasticsearch:latest  . 
```

**Step 2.** Create a container using the image. 
```bash
# -n: name
# -m: memory size
# -P: expose ports mentioned in Dockerfile
docker create --name elasticsearch -m 1GB -d -P -t local/elasticsearch:latest
```

**Step 3.** Run the container.
```bash
# --env-file: path to file where environment variables are defined
# -d: daemon mode
docker run --env-file .env -d local/elasticsearch:latest
```

**Step 4.** Stop the container. 
```bash
docker stop elasticsearch
```

**Step 3.** Remove the container. 
```bash
docker rm elasticsearch
```

**Step 4.** Remove the image. 
```bash
docker rmi local/elasticsearch:latest
```