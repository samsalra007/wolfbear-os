# syntax=docker/dockerfile:1.4

FROM alpine:3.21 AS builder

# Instalar herramientas
RUN apk add --no-cache \
    apk-tools \
    rsync \
    ca-certificates \
    openssl \
    zlib

# Regenerar bundle CA
RUN update-ca-certificates

# Preparar estructura de salida
ENV OUT=/out
RUN mkdir -p $OUT/sbin \
    $OUT/lib/apk/db \
    $OUT/var/lib/apk/db \
    $OUT/etc/apk \
    $OUT/etc/ssl \
    $OUT/usr/lib

# Copiar binario apk
ENV APKBIN=/sbin/apk
RUN cp $APKBIN $OUT/sbin/

# Copiar librerías y datos
RUN ldd $APKBIN \
    | grep -oE '/(usr/)?lib[^ ]+' \
    | xargs -r -I{} cp --parents {} $OUT && \
    cp -a /usr/lib $OUT/usr/ && \
    mkdir -p $OUT/lib/apk/db && cp -r /lib/apk/db/* $OUT/lib/apk/db/ && \
    mkdir -p $OUT/var/lib/apk/db && cp -r /var/lib/apk/db/* $OUT/var/lib/apk/db/ 2>/dev/null || true && \
    cp /var/lib/apk/world $OUT/var/lib/apk/world 2>/dev/null || true && \
    cp -r /etc/apk $OUT/etc/apk && \
    cp -a /etc/ssl $OUT/etc/ssl

# Imagen final
FROM alpine:3.21
RUN apk add --no-cache rsync
COPY --from=builder /out /target
CMD ["sh", "-c", "rsync -a /target/ /real-target/"]
