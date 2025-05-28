#include <SDL2/SDL.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Iniciando aplicación SDL\n");
    fflush(stdout);

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        fprintf(stderr, "SDL_Init error: %s\n", SDL_GetError());
        return 1;
    }

    printf("SDL inicializado correctamente\n");
    fflush(stdout);

    SDL_Window *window = SDL_CreateWindow(
        "WolfbearLauncherApp",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        1024, 576,
        SDL_WINDOW_SHOWN
    );
    if (!window) {
        fprintf(stderr, "SDL_CreateWindow error: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1,
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer) {
        fprintf(stderr, "SDL_CreateRenderer error: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    SDL_SetRenderDrawColor(renderer, 128, 128, 128, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);

    printf("Ventana renderizada\n");
    fflush(stdout);

    SDL_Event evt;
    Uint32 start = SDL_GetTicks();
    while (SDL_GetTicks() - start < 5000) {
        while (SDL_PollEvent(&evt)) {
            if (evt.type == SDL_QUIT) {
                return 0;
            }
        }
        SDL_Delay(10);
    }

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    printf("Saliendo de la aplicación\n");
    fflush(stdout);
    return 0;
}
