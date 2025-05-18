FROM alpine:latest

# Instalar dependencias de SDL2 y multimedia (devel packages incluyen .so y .a)
#    sdl2-dev		# SDL2 (librería + headers):contentReference[oaicite:3]{index=3}, incluye mesa-dev para GL/EGL
#    libdrm-dev		# DRM/GBM user-space (libdrm) y cabeceras
#    libpciaccess-dev	# Acceso a PCI (necesario para libdrm)
#    libffi-dev		# libffi (dinámico y estático):contentReference[oaicite:4]{index=4}
#    expat-dev		# Expat (dinámico)
#    expat-static	# Expat (estático) para obtener libexpat.a:contentReference[oaicite:5]{index=5}

RUN apk update && apk add --no-cache \
    sdl2-dev \
    libdrm-dev \
    libpciaccess-dev \
    libffi-dev \
    expat-dev \ 
    expat-static

# Crear estructura de sysroot en /target
RUN mkdir -p /target/usr/lib /target/usr/include

# Copiar bibliotecas dinámicas (.so) de SDL2 y dependencias a /target/usr/lib
RUN cp /usr/lib/libSDL2-2.0.so* /target/usr/lib/   && \
    cp /usr/lib/libSDL2.so /target/usr/lib/        && \
    cp /usr/lib/libEGL.so* /target/usr/lib/        && \
    cp /usr/lib/libGL.so* /target/usr/lib/         && \
    cp /usr/lib/libGLESv1_CM.so* /target/usr/lib/  && \
    cp /usr/lib/libGLESv2.so* /target/usr/lib/     && \
    cp /usr/lib/libgbm.so* /target/usr/lib/        && \
    cp /usr/lib/libdrm*.so* /target/usr/lib/       && \
    cp /usr/lib/libexpat.so* /target/usr/lib/      && \
    cp /usr/lib/libffi.so* /target/usr/lib/        && \
    cp /usr/lib/libstdc++.so* /target/usr/lib/     && \
    cp /usr/lib/libgcc*.so* /target/usr/lib/

# Copiar bibliotecas estáticas (.a) necesarias a /target/usr/lib
RUN cp /usr/lib/libSDL2.a /target/usr/lib/    && \
    cp /usr/lib/libSDL2_test.a /target/usr/lib/ && \
    cp /usr/lib/libSDL2main.a /target/usr/lib/ && \
    cp /usr/lib/libffi.a /target/usr/lib/       && \
    cp /usr/lib/libexpat.a /target/usr/lib/

# Copiar headers de SDL2 y dependencias a /target/usr/include
RUN cp -r /usr/include/SDL2 /target/usr/include/ && \
    cp -r /usr/include/libdrm /target/usr/include/ && \
    cp -r /usr/include/EGL /target/usr/include/ && \
    cp -r /usr/include/GL /target/usr/include/  && \
    cp -r /usr/include/GLES* /target/usr/include/ && \
    cp -r /usr/include/KHR /target/usr/include/ && \
    cp /usr/include/expat*.h /target/usr/include/ && \
    cp /usr/include/ffi*.h /target/usr/include/

# Crear /target/lib y copiar el loader + libc de musl
RUN mkdir -p /target/lib && \
    cp /lib/ld-musl-aarch64.so.1   /target/lib/ && \
    cp /lib/libc.musl-aarch64.so.1 /target/lib/

# Fin. El contenedor copiará los ficheros y luego terminará automáticamente.

