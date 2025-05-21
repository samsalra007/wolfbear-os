# syntax=docker/dockerfile:1.4

FROM alpine:3.21 AS builder

# 1) Instalar apk-tools y dependencias, actualizar bundle de CA
RUN apk add --no-cache \
    apk-tools \
    rsync \
    ca-certificates \
    openssl \
    zlib && \
    update-ca-certificates

# 2) Variables de entorno
ENV OUT=/out APKBIN=/sbin/apk

# 3) Crear estructura de salida
RUN mkdir -p \
    $OUT/sbin \
    $OUT/lib/apk/db \
    $OUT/var/lib/apk/db \
    $OUT/etc/apk \
    $OUT/etc/ssl \
    $OUT/usr/lib

# 4) Copiar binario 'apk'
RUN cp $APKBIN $OUT/sbin/

# 5) Copiar librerías, configuración y certificados
RUN ldd $APKBIN \
    | grep -oE '/(usr/)?lib[^ ]+' \
    | xargs -r -I{} cp --parents {} $OUT && \
    cp -r /etc/apk $OUT/etc/apk && \
    cp -a /etc/ssl $OUT/etc/ssl

# 6) Imagen final mínima
FROM alpine:3.21
RUN apk add --no-cache rsync
COPY --from=builder /out /target
CMD ["sh", "-c", "rsync -a /target/ /real-target/"]
