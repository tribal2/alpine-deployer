# alpine-deployer
Lightweight Docker image (Alpine based) with SSH client and RSync installed for deployment jobs.

## Using the image from Docker Hub
```bash
docker pull alpine-deployer
```

## Building the image for local use
```bash
docker build \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  -t alpine-deployer \
  .
```