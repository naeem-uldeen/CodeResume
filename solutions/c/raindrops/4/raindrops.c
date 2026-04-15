#include "raindrops.h"
#include <string.h>
#include <stdio.h>

typedef struct {
    int divisor;
    char* sound;
} Raindrop;

void convert(char result[], int number) {
    const int SOUND_LENGTH = 5;
    const int DROP_LENGTH = 3;

    Raindrop raindrops[] = {
        {3, "Pling"},
        {5, "Plang"},
        {7, "Plong"}
    };

    char* ptr_drop = result;

    for (int i = 0; i < DROP_LENGTH; i++) {
        if (number % raindrops[i].divisor == 0) {
            memcpy(ptr_drop, raindrops[i].sound, SOUND_LENGTH);
            ptr_drop += SOUND_LENGTH;
        }
    }

    *ptr_drop = '\0';

    if (result[0] == '\0') sprintf(result, "%d", number);
}
