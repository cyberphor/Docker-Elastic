# Elasticsearch

**Step 1.** Build an image of Elasticsearch.
```bash
# -t: tag (e.g., registry/app:version)
# -f: path to Dockerfile
# .: use the current working directory as the build context (i.e., build from here)
docker build -t local/elasticsearch:latest -f Dockerfile  . 
```

**Step 2.** Create a container using the image. 
```bash
# -n: name
docker create -t local/elasticsearch:latest -n elasticsearch -m 1GB -p 9200:9200 --env-file .env 
```

**Step 3.** Run the container.
```bash
# -m: memory size
# -p: expose ports mentioned in Dockerfile
# --env-file: path to file where environment variables are defined
# -d: daemon mode
docker run  -m 1GB local/elasticsearch:latest
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