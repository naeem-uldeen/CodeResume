#include "rotational_cipher.h"
#include "rotational_cipher.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ALPHABET_LENGTH 26

char* rotate(const char* text, int shift_key) {
    shift_key = ((shift_key % ALPHABET_LENGTH) + ALPHABET_LENGTH) % ALPHABET_LENGTH;
    size_t len = strlen(text);
    char* deciphered = malloc((len + 1) * sizeof(char));
    if (!deciphered) return NULL;
    
    for (size_t i = 0; i < len; i++) {
        char c = text[i];
        if (isalpha(c)) {
            char base = islower(c) ? 'a' : 'A';
            int position = c - base;
            int new_position = (position + shift_key) % ALPHABET_LENGTH;
            deciphered[i] = base + new_position;
        } else {
            deciphered[i] = c;
        }
    }
    
    deciphered[len] = '\0';
    return deciphered;
}
