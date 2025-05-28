#include <SDL2/SDL.h>
#include <stdio.h>

int main(void) {
    if (SDL_Init(0) < 0) {
        fprintf(stderr, "SDL_Init error: %s\n", SDL_GetError());
        return 1;
    }

    // 1) Listar video drivers
    int num_vd = SDL_GetNumVideoDrivers();
    printf("SDL2 video drivers (%d):\n", num_vd);
    for (int i = 0; i < num_vd; ++i) {
        printf("  %s\n", SDL_GetVideoDriver(i));
    }

    // 2) Listar render drivers
    int num_rd = SDL_GetNumRenderDrivers();
    printf("SDL2 render drivers (%d):\n", num_rd);
    for (int i = 0; i < num_rd; ++i) {
        SDL_RendererInfo info;
        if (SDL_GetRenderDriverInfo(i, &info) == 0) {
            printf("  [%d] %s (flags:", i, info.name);
            if (info.flags & SDL_RENDERER_SOFTWARE)    printf(" SOFTWARE");
            if (info.flags & SDL_RENDERER_ACCELERATED) printf(" ACCEL");
            if (info.flags & SDL_RENDERER_PRESENTVSYNC)printf(" VSYNC");
            if (info.flags & SDL_RENDERER_TARGETTEXTURE) printf(" TARGET_TEX");
            printf(" )\n");
        }
    }

    SDL_Quit();
    return 0;
}