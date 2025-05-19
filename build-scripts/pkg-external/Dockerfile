# Dockerfile (Alpine 3.21, ARM64)
FROM alpine:3.21

RUN apk update && apk add --no-cache \
      build-base \
      linux-headers \
      sdl2-dev \
      mesa-dev \
      libdrm-dev \
      wayland-dev \
      wayland-protocols-dev \
      expat-dev \
      expat-static \
      libffi-dev \
      file \
      rsync \
      pkgconf \
      libmagic \
      eudev-libs \
      eudev-dev \
      ninja \
      pkgconf \
      python3 \
      py3-meson \
      ninja \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /target/usr/{include,lib} /target/lib /target/usr/bin /target/usr/share/misc

# 1) Headers
RUN rsync -a --links /usr/include/        /target/usr/include/

# 2) Bibliotecas dinámicas (rsync preserva symlinks correctamente)
RUN rsync -a --links /usr/lib/libSDL2*.so*       /target/usr/lib/ && \
    rsync -a --links /usr/lib/libGLESv*.so*      /target/usr/lib/ && \
    rsync -a --links /usr/lib/libEGL*.so*        /target/usr/lib/ && \
    rsync -a --links /usr/lib/libGL*.so*         /target/usr/lib/ && \
    rsync -a --links /usr/lib/libgbm*.so*        /target/usr/lib/ && \
    rsync -a --links /usr/lib/libdrm*.so*        /target/usr/lib/ && \
    rsync -a --links /usr/lib/libwayland-*.so*   /target/usr/lib/ && \
    rsync -a --links /usr/lib/libexpat*.so*      /target/usr/lib/ && \
    rsync -a --links /usr/lib/libffi*.so*        /target/usr/lib/ && \
    rsync -a --links /usr/lib/libmagic.so*       /target/usr/lib/ && \
    rsync -a --links /usr/lib/libudev*.so*       /target/usr/lib/

# 3) Bibliotecas estáticas
RUN find /usr/lib -maxdepth 1 -name '*.a' -exec rsync -a --links {} /target/usr/lib/ \; || true

# 4) Loader + libc de musl
RUN cp /lib/ld-musl-aarch64.so.1   /target/lib/ && \
    cp /lib/libc.musl-aarch64.so.1 /target/lib/

# 5) Herramientas mínimas
RUN cp /usr/bin/file    /target/usr/bin/ && \
    cp /usr/bin/ldd     /target/usr/bin/ && \
    cp /usr/bin/pkgconf /target/usr/bin/

# 6) Base de datos de magic
RUN cp /usr/share/misc/magic.mgc /target/usr/share/misc/

# 3) Copia Meson + Ninja + Python3 para poder correr Meson en tu rootfs
RUN cp /usr/bin/meson /target/usr/bin/ && \
    cp /usr/bin/ninja /target/usr/bin/ && \
    cp /usr/bin/python3 /target/usr/bin/ && \
    # Copia librería de Python y módulos meson:
    rsync -a --links /usr/lib/python3*/ /target/usr/lib/python3*/ && \
    rsync -a --links /usr/lib/python3*/site-packages/meson* /target/usr/lib/python3*/site-packages/


RUN chmod -R u+rwX /target

CMD ["sh","-c","echo '✓ Sysroot ARM64-musl listo en /target'"]
