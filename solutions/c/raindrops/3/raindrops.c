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

    char* ptr_drop = result;

    for (int i = 0; i < 3; i++) {
        if (number % drops[i].divisor == 0) {
            memcpy(ptr_drop, drops[i].sound, 5);
            ptr_drop += 5;
        }
    }

    *ptr_drop = '\0';

    if (result[0] == '\0') sprintf(result, "%d", number);
}
