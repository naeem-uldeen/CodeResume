#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char* reverse(const char* text) {
    size_t size = strlen(text);
    size_t last_index = size - 1;
    char* reversed = malloc(size + 1);
    
    for (size_t i = 0; i < size; i++) {
        reversed[i] = text[last_index - i];
    }
    reversed[size] = '\0';
    
    return reversed;
}
