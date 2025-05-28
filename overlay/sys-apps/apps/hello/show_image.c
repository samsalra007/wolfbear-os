#include <SDL2/SDL.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s imagen.bmp\n", argv[0]);
        return 1;
    }

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("No se pudo inicializar SDL: %s\n", SDL_GetError());
        return 1;
    }

    SDL_Window *window = SDL_CreateWindow("Instalando...",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
        1366, 768, SDL_WINDOW_SHOWN | SDL_WINDOW_FULLSCREEN);

    if (!window) {
        printf("No se pudo crear la ventana: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE);
    if (!renderer) {
        printf("No se pudo crear el renderer: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    SDL_Surface *image = SDL_LoadBMP(argv[1]);
    if (!image) {
        printf("No se pudo cargar la imagen: %s\n", SDL_GetError());
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
        return 1;
    }

    int img_w = image->w, img_h = image->h;
    printf("Imagen cargada: %dx%d\n", img_w, img_h);

    int tex_w, tex_h;
    if (SDL_QueryTexture(texture, NULL, NULL, &tex_w, &tex_h) == 0) {
        printf("Textura creada: %dx%d\n", tex_w, tex_h);
    } else {
        printf("Error en SDL_QueryTexture: %s\n", SDL_GetError());
    }

    SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, image);
    SDL_FreeSurface(image);

    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);

    // Espera 10 segundos (o hasta que el proceso termine)
    SDL_Delay(10000);

    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}