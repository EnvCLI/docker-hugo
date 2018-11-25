############################################################
# Dockerfile
############################################################

# Set the base image
FROM alpine:3.8

############################################################
# Configuration
############################################################
ENV VERSION "0.46.0"

############################################################
# Installation
############################################################

RUN apk add --no-cache ca-certificates bash curl tar gzip coreutils &&\
    # so apparently their x.y.0 releases are flagged as x.y, this is a workaround for that
    if [ "${VERSION:$length:1}" == "0" ]; then export REALVERSION=${VERSION::-2}; else export REALVERSION=${VERSION}; fi &&\
    # Install Hugo
    curl -L -o /tmp/data.tar.gz https://github.com/gohugoio/hugo/releases/download/v${REALVERSION}/hugo_${REALVERSION}_Linux-64bit.tar.gz &&\
    tar xzvf /tmp/data.tar.gz -C /tmp/ &&\
    mv /tmp/hugo /usr/local/bin &&\
    chmod +x /usr/local/bin/hugo &&\
    rm -rf /tmp/* &&\
    # CleanUp
    apk del curl tar gzip

############################################################
# Execution
############################################################
CMD ["hugo", "help"]
