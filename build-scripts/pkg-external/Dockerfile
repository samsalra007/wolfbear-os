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
      meson \
      ninja \
      mesa-dri-gallium \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /target/usr/{include,lib} /target/lib /target/usr/bin /target/usr/share/misc

# 1) Headers
RUN rsync -a --links /usr/include/        /target/usr/include/
RUN rsync -a --links /usr/include/SDL2   /target/usr/include/SDL2 && \
    rsync -a --links /usr/include/libdrm /target/usr/include/libdrm && \
    rsync -a --links /usr/include/EGL    /target/usr/include/EGL && \
    rsync -a --links /usr/include/wayland* /target/usr/include/

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

# 4) Copia la librería estándar de Python + Meson
RUN for P in /usr/lib/python3.*; do \
      dest="/target/usr/lib/$(basename $P)"; \
      mkdir -p "$dest"; \
      rsync -a --links "$P/" "$dest/"; \
      # ahora solo los módulos meson:
      rsync -a --links "$P/site-packages/meson"* "$dest/site-packages/"; \
    done

# Copia los modulos drivers graficos
RUN rsync -a --links /usr/lib/dri/ /target/usr/lib/dri/

RUN chmod -R u+rwX /target

CMD ["sh","-c","echo '✓ Sysroot ARM64-musl listo en /target'"]
