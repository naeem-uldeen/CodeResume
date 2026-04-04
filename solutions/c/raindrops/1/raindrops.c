#include "raindrops.h"
#include <string.h>
#include <stdio.h>

void convert(char result[], int number) {
    result[0] = '\0';

    if (number % 3 == 0) {
        strcat(result, "Pling");    
    } 
    if (number % 5 == 0) { 
        strcat(result, "Plang");
    }
    if (number % 7 == 0) {
        strcat(result, "Plong");    
    } 
    if (result[0] == '\0') {
        sprintf(result, "%d", number);
    }
}
