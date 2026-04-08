#include "reverse_string.h"
#include <stdlib.h>

char* reverse(const char* text) {
    size_t size = 0;
    while (text[size] != '\0') size++;
    char* reversed = malloc(size + 1);

    for (size_t i = 0; i < size; i++) {
        reversed[i] = text[size - 1 - i];
    }
    reversed[size] = '\0';

    return reversed;
}
