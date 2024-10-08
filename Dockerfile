FROM jwilder/docker-gen

# Install openssl for signing certificates
RUN apk update && \
    apk upgrade && \
    apk add --no-cache openssl

# Set default parameters
ENV GENERATOR="self-signed"\
    CERT_FOLDER="/data/certs"\
    CA_FOLDER="/data/ca"\
    DOCKER_HOST="unix:///tmp/docker.sock"\
    PATH="/app/bin/:$PATH"

# Add config files into container
ADD root-files /

# Add start script
ADD docker-entrypoint.sh /

# Create necessary folders to avoid errors
RUN mkdir -p $CERT_FOLDER && mkdir -p $CA_FOLDER

# Remove entrypoint from parent
# Parent image gives many nice features if you want to run it as a tool
# We only want to start this image without many parameters
ENTRYPOINT []

CMD ["/docker-entrypoint.sh"]
