#include <fcntl.h>
#include <stdio.h>
#include <xf86drm.h>
#include <gbm.h>

int main(){
    printf("Abrir render node…\n");
    int fd = open("/dev/dri/renderD128", O_RDWR);
    if (fd < 0) { perror("open renderD128"); return 1; }
    printf("fd=%d OK. Crear GBM device…\n", fd);
    struct gbm_device *gbm = gbm_create_device(fd);
    if (!gbm) { fprintf(stderr, "gbm_create_device failed\n"); return 1; }
    printf("¡GBM device OK!\n");
    return 0;
}
