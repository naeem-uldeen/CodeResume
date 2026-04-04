#include "raindrops.h"
#include <string.h>
#include <stdio.h>

typedef struct {
    int divisor;
    char* sound;
} Raindrop;

void convert(char result[], int number) {
    Raindrop drops[] = {
        {3, "Pling"},
        {5, "Plang"},
        {7, "Plong"}
    };

    result[0] = '\0';

    for (int i = 0; i < 3; i++) {
        if (number % drops[i].divisor == 0) {
            strcat(result, drops[i].sound);
        }
    }

    if (result[0] == '\0') sprintf(result, "%d", number);
}
