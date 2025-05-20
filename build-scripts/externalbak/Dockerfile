# syntax=docker/dockerfile:1.4

FROM alpine:3.21 AS builder

RUN apk add --no-cache \
    apk-tools \
    rsync \
    ca-certificates \
    openssl \
    zlib && \
    update-ca-certificates

# Preparar todos los archivos necesarios para copiar
RUN mkdir -p /out/sbin \
    /out/lib/apk/db \
    /out/var/lib/apk/db \
    /out/etc/apk \
    /out/etc/ssl/certs \
    /out/usr/lib \
    /out/lib && \
  cp /sbin/apk /out/sbin/apk && \
  ldd /sbin/apk | grep -oE '/(usr/)?lib[^ ]+' | xargs -I{} cp --parents {} /out || true && \
  cp -r /lib/apk/db/* /out/lib/apk/db/ 2>/dev/null || true && \
  cp -r /var/lib/apk/db/* /out/var/lib/apk/db/ 2>/dev/null || true && \
  cp /var/lib/apk/world /out/var/lib/apk/world 2>/dev/null || true && \
  cp -r /etc/apk/* /out/etc/apk/ 2>/dev/null || true && \
  update-ca-certificates && \
  cp /etc/ssl/certs/ca-certificates.crt /out/etc/ssl/certs/

FROM alpine:3.21

RUN apk add --no-cache rsync

COPY --from=builder /out /target

CMD ["sh", "-c", "rsync -a /target/ /real-target/"]
