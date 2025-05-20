# syntax=docker/dockerfile:1.4

FROM alpine:3.21 AS builder

# 1) Instalar herramientas base
RUN apk add --no-cache \
    apk-tools \
    rsync \
    ca-certificates \
    openssl \
    zlib && \
    update-ca-certificates

# 2) Variables de entorno
ENV OUT=/out
ENV APKBIN=/sbin/apk

# 3) Crear estructura de salida
RUN mkdir -p $OUT/sbin \
    $OUT/lib/apk/db \
    $OUT/var/lib/apk/db \
    $OUT/etc/apk \
    $OUT/etc/ssl \
    $OUT/usr/lib

# 4) Copiar binario 'apk'
RUN cp $APKBIN $OUT/sbin/

# 5) Copiar librerías, índices y estado
RUN ldd $APKBIN \
    | grep -oE '/(usr/)?lib[^ ]+' \
    | xargs -r -I{} cp --parents {} $OUT && \
    cp -r /lib/apk/db/* $OUT/lib/apk/db/ && \
    cp -r /var/lib/apk/db/* $OUT/var/lib/apk/db/ 2>/dev/null || true && \
    cp /var/lib/apk/world $OUT/var/lib/apk/world 2>/dev/null || true

# 6) Copiar configuración y certificados
RUN cp -r /etc/apk $OUT/etc/apk && \
    cp -a /etc/ssl $OUT/etc/ssl

# 7) Imagen final mínima
FROM alpine:3.21
RUN apk add --no-cache rsync
COPY --from=builder /out /target
CMD ["sh", "-c", "rsync -a /target/ /real-target/"]
