FROM cloudsuite/base-os:debian

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    bc \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY files /root/
RUN set -x \
    && mkdir -p /root/build \
    && cd /root/build \
    && /root/videoperf/configure \
    && make \
    && make install

RUN chmod +x /root/docker-entrypoint.sh

RUN rm -rf /output && mkdir -p /output
VOLUME ["/output"]

RUN rm -rf /videos/logs && mkdir -p /videos/logs
VOLUME [ "/videos/logs" ]

RUN apt -y update \
    && apt install -y strace
RUN which strace

ENTRYPOINT ["/root/docker-entrypoint.sh"]
