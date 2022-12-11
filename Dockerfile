# OS
FROM ubuntu:latest
# Set version label
LABEL maintainer="github.com/Dofamin"
LABEL image="Prometheus-Exporter"
LABEL OS="Ubuntu/latest"
COPY container-image-root/ /
# ARG & ENV
WORKDIR /srv/
ENV TZ=Europe/Moscow
# Update system packages:
RUN apt -y update > /dev/null 2>&1;\
# Fix for select tzdata region
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone > /dev/null 2>&1;\
    dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1;\
# Install dependencies, you would need common set of tools.
    apt -y install golang-go git wget curl ntp make > /dev/null 2>&1;\
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - > /dev/null 2>&1;\
    apt -y install nodejs > /dev/null 2>&1;\
## Clone the repo:
    git clone https://github.com/prometheus/node_exporter.git  > /dev/null 2>&1; \
    cd node_exporter > /dev/null 2>&1; \
# Start installer
    make build > /dev/null 2>&1; \
# Cleanup
    apt -y autoremove > /dev/null 2>&1; \
    apt -y remove golang-go > /dev/null 2>&1; \
    rm -rf /root/go > /dev/null 2>&1; \
    rm -rf /root/.cache > /dev/null 2>&1; \
    rm -rf /root/.npm > /dev/null 2>&1; \
    mkdir /srv/config > /dev/null 2>&1;
# HEALTHCHECK
HEALTHCHECK --interval=60s --timeout=30s --start-period=5s CMD curl -f http://localhost:9090 || exit 1
# Expose Ports:
EXPOSE 9100
WORKDIR /srv/node_exporter
# ENTRYPOINT
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]