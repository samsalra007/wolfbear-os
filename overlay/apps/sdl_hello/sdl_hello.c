#include <SDL2/SDL.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Available SDL video drivers:\n");
    fflush(stdout);

    for (int i = 0; i < SDL_GetNumVideoDrivers(); i++) {
        printf("  %s\n", SDL_GetVideoDriver(i));
	fflush(stdout);
    }

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("SDL_Init error: %s\n", SDL_GetError());
        fflush(stdout);
        return 1;
    }

    printf("SDL video driver: %s\n", SDL_GetCurrentVideoDriver());
    fflush(stdout);

    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window = SDL_CreateWindow("Hello SDL",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        640, 480, SDL_WINDOW_SHOWN);

    SDL_Delay(5000);

    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
