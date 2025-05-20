# Dockerfile (Alpine 3.21, ARM64)
FROM alpine:3.21

# 1) Instala todas las dependencias (no tocar)
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
      python3 \
      meson \
      mesa-dri-gallium \
    && rm -rf /var/cache/apk/*

# 2) Crea layout de sysroot (incluye dri)
RUN mkdir -p /target/usr/{include,lib,dri} \
             /target/lib \
             /target/usr/bin \
             /target/usr/share/misc

# 3) Headers (igual que antes)
RUN rsync -a --links /usr/include/        /target/usr/include/
RUN rsync -a --links /usr/include/SDL2   /target/usr/include/SDL2 \
 && rsync -a --links /usr/include/libdrm /target/usr/include/libdrm \
 && rsync -a --links /usr/include/EGL    /target/usr/include/EGL \
 && rsync -a --links /usr/include/wayland* /target/usr/include/

# 4) Bibliotecas dinámicas (igual que antes)
RUN rsync -a --links /usr/lib/libSDL2*.so*     /target/usr/lib/ \
 && rsync -a --links /usr/lib/libGLESv*.so*    /target/usr/lib/ \
 && rsync -a --links /usr/lib/libEGL*.so*      /target/usr/lib/ \
 && rsync -a --links /usr/lib/libGL*.so*       /target/usr/lib/ \
 && rsync -a --links /usr/lib/libgbm*.so*      /target/usr/lib/ \
 && rsync -a --links /usr/lib/libdrm*.so*      /target/usr/lib/ \
 && rsync -a --links /usr/lib/libwayland-*.so* /target/usr/lib/ \
 && rsync -a --links /usr/lib/libexpat*.so*    /target/usr/lib/ \
 && rsync -a --links /usr/lib/libffi*.so*      /target/usr/lib/ \
 && rsync -a --links /usr/lib/libmagic.so*     /target/usr/lib/ \
 && rsync -a --links /usr/lib/libudev*.so*     /target/usr/lib/

# 5) Bibliotecas estáticas (igual que antes)
RUN find /usr/lib -maxdepth 1 -name '*.a' -exec rsync -a --links {} /target/usr/lib/ \; || true

# 6) Loader + libc de musl (igual que antes)
RUN cp /lib/ld-musl-aarch64.so.1   /target/lib/ \
 && cp /lib/libc.musl-aarch64.so.1 /target/lib/

# 7) Herramientas mínimas (igual que antes)
RUN cp /usr/bin/file    /target/usr/bin/ \
 && cp /usr/bin/ldd     /target/usr/bin/ \
 && cp /usr/bin/pkgconf /target/usr/bin/

# 8) Magic DB (igual que antes)
RUN cp /usr/share/misc/magic.mgc /target/usr/share/misc/

# 9) Python + Meson + Ninja (igual que antes)
RUN for P in /usr/lib/python3.*; do \
      dest="/target/usr/lib/$(basename $P)"; \
      mkdir -p "$dest"/site-packages && \
      rsync -a --links "$P/" "$dest/"; \
      rsync -a --links "$P/site-packages/meson"* "$dest/site-packages/"; \
    done

# 10) Módulos DRI: primero verifica qué hay en /usr/lib/dri
RUN echo "Contenido de /usr/lib/dri en contenedor:" && ls -l /usr/lib/dri

#    luego cópialos todos
RUN mkdir -p /target/usr/lib/dri/ && \
      rsync -a --links /usr/lib/xorg/modules/dri/ /target/usr/lib/dri/

# 11) Permisos finales
RUN chmod -R u+rwX /target

CMD ["sh","-c","echo '✓ Sysroot ARM64-musl listo en /target'"]
