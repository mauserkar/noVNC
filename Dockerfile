FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -fy procps git python3 python3-pip && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    python3 -m pip install numpy && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /app

COPY . .

RUN git clone https://github.com/kanaka/websockify /app/utils/websockify

EXPOSE 6080

RUN cp /app/vnc.html /app/index.html

ENTRYPOINT ["/app/utils/novnc_proxy"]