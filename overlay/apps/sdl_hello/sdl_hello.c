#include <SDL2/SDL.h>

int main(int argc, char *argv[]) {
    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window = SDL_CreateWindow("Hello SDL",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        640, 480, SDL_WINDOW_SHOWN);

    SDL_Delay(2000); // Esperar 2 segundos

    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
