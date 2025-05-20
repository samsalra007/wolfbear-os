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
env OUT=/out
RUN mkdir -p $OUT/sbin \
    $OUT/lib/apk/db \
    $OUT/var/lib/apk/db \
    $OUT/etc/apk \
    $OUT/etc/ssl/certs \
    $OUT/usr/lib

# Copiar binario apk y todas sus dependencias y datos
ENV APKBIN=/sbin/apk
RUN cp $APKBIN $OUT/sbin/ && \
    ldd $APKBIN | grep -oE '/(usr/)?lib[^ ]+' | xargs -r -I{} cp --parents {} $OUT && \
    # Copiar índices de repositorios
    mkdir -p $OUT/lib/apk/db && cp -r /lib/apk/db/* $OUT/lib/apk/db/ && \
    # Copiar estado de instalación
    mkdir -p $OUT/var/lib/apk/db && cp -r /var/lib/apk/db/* $OUT/var/lib/apk/db/ 2>/dev/null || true && \
    cp /var/lib/apk/world $OUT/var/lib/apk/world 2>/dev/null || true && \
    # Copiar configuración de repos
    cp -r /etc/apk/* $OUT/etc/apk/ && \
    # Copiar certificados SSL
    cp -a /etc/ssl $OUT/etc/ssl

FROM alpine:3.21
# instalar rsync para copiar correctamente enlaces simbólicos
RUN apk add --no-cache rsync

COPY --from=builder /out /target

CMD ["sh", "-c", "rsync -a /target/ /real-target/"] ["sh", "-c", "rsync -a /target/ /real-target/"]
