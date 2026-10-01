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

RUN git clone --depth 1 https://github.com/xmrig/xmrig.git /tmp/xmrig

RUN mkdir -p /tmp/xmrig/build && \
    cd /tmp/xmrig/build && \
    cmake .. \
        -DWITH_HWLOC=ON \
        -DWITH_TLS=ON \
        -DWITH_HTTPD=OFF && \
    make -j"$(nproc)" && \
    cp xmrig /app/xmrig

COPY config_ltc.json /app/config_ltc.json
COPY start_railway.sh /app/start_railway.sh

RUN chmod +x /app/xmrig \
    /app/start_railway.sh

CMD ["/app/start_railway.sh"]
