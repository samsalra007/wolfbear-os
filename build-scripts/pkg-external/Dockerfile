# build-scripts/pkg-external/Dockerfile
FROM alpine:3.21

RUN apk update && apk add --no-cache \
      build-base \
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
      libdrm libdrm-dev mesa-gbm mesa-dev eudev-libs eudev-dev \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /target/usr/include /target/usr/lib /target/lib /target/usr/bin /target/usr/share/misc

# 1) Copiar TODOS los headers de /usr/include
RUN rsync -a --links /usr/include/ /target/usr/include/

# 2) Copiar headers específicos de SDL2, libdrm, EGL, Wayland
RUN rsync -a --links /usr/include/SDL2/   /target/usr/include/SDL2/ && \
    rsync -a --links /usr/include/libdrm/ /target/usr/include/libdrm/ && \
    rsync -a --links /usr/include/EGL/    /target/usr/include/EGL/ && \
    rsync -a --links /usr/include/wayland*/ /target/usr/include/

# 3) Copiar librerías dinámicas concretas a sysroot
RUN for lib in \
      /usr/lib/libSDL2*.so* \
      /usr/lib/libGLESv*.so* \
      /usr/lib/libEGL*.so* \
      /usr/lib/libGL*.so* \
      /usr/lib/libgbm*.so* \
      /usr/lib/libdrm*.so* \
      /usr/lib/libwayland-*.so* \
      /usr/lib/libexpat*.so* \
      /usr/lib/libffi*.so* \
      /usr/lib/libdrm*.so* \
      /usr/lib/libgbm*.so* \
      /usr/lib/libudev*.so*; do \
    [ -f "$lib" ] && cp -a "$lib" /target/usr/lib/; \
  done

# 4) Copiar librerías estáticas (.a) si existen
RUN for a in /usr/lib/*.a; do \
    [ -f "$a" ] && cp -a "$a" /target/usr/lib/; \
  done

# 5) Copiar loader y libc de musl
RUN cp /lib/ld-musl-aarch64.so.1   /target/lib/ && \
    cp /lib/libc.musl-aarch64.so.1 /target/lib/

# 6) Copiar herramientas mínimas
RUN cp /usr/bin/file    /target/usr/bin/ && \
    cp /usr/bin/ldd     /target/usr/bin/ && \
    cp /usr/bin/pkgconf /target/usr/bin/

# 7) Magic database para file
RUN cp /usr/share/misc/magic.mgc /target/usr/share/misc/

# 8) Ajustar permisos
RUN chmod -R u+rwX /target

CMD ["sh", "-c", "echo '✓ Sysroot ARM64-musl listo en /target'"]

