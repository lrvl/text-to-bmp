#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TEXT_SIZE 50000  // Adjust based on your needs.

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <path_to_text_file>\n", argv[0]);
        return 1;
    }

    char text[MAX_TEXT_SIZE];
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    fread(text, sizeof(char), MAX_TEXT_SIZE - 1, file);
    text[MAX_TEXT_SIZE - 1] = '\0';  // Null-terminate the string
    fclose(file);

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
        return 1;
    }

    if (TTF_Init() == -1) {
        printf("SDL_ttf could not initialize! SDL_ttf Error: %s\n", TTF_GetError());
        return 1;
    }

    TTF_Font *font = TTF_OpenFont("/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf",12);

    if (font == NULL) {
        printf("Failed to load font! SDL_ttf Error: %s\n", TTF_GetError());
        return 1;
    }

    SDL_Color textColor = {0, 255, 0, 255};  // Green color, fully opaque


    // Split the text into lines and render
    char *line = strtok(text, "\n");
    SDL_Surface *lineSurface = NULL;
    SDL_Surface *combinedSurface = SDL_CreateRGBSurface(0, 1920, 1080, 32, 0, 0, 0, 0);  // Assuming a resolution of 1920x1080 for now
    int yOffset = 0;

    while (line) {
        lineSurface = TTF_RenderText_Blended(font, line, textColor);
        if (lineSurface) {
            SDL_Rect destRect = {0, yOffset, lineSurface->w, lineSurface->h};
            SDL_BlitSurface(lineSurface, NULL, combinedSurface, &destRect);
            yOffset += lineSurface->h;
            SDL_FreeSurface(lineSurface);
        }
        line = strtok(NULL, "\n");
    }

    // Save the combined surface to a file
    SDL_SaveBMP(combinedSurface, "/app/output/output.bmp");

    SDL_FreeSurface(combinedSurface);
    TTF_CloseFont(font);
    TTF_Quit();
    SDL_Quit();

    return 0;
}

