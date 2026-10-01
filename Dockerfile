FROM debian:13

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY xmrig-build/src /app/xmrig-src
COPY config_ltc.json /app/config_ltc.json
COPY start_railway.sh /app/start_railway.sh

RUN mkdir -p /app/xmrig-build && \
    cd /app/xmrig-build && \
    cmake /app/xmrig-src \
        -DWITH_HWLOC=ON \
        -DWITH_TLS=ON \
        -DWITH_HTTPD=OFF && \
    make -j"$(nproc)"

RUN chmod +x /app/start_railway.sh

CMD ["/app/start_railway.sh"]
