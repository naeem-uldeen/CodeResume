#include "rotational_cipher.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ALPHABET_LENGTH 26

static char rotate_lowercase(char c, int shift_key) {
    return (c - 'a' + shift_key) % ALPHABET_LENGTH + 'a';
}

static char rotate_uppercase(char c, int shift_key) {
    return (c - 'A' + shift_key) % ALPHABET_LENGTH + 'A';
}

char* rotate(const char* text, int shift_key) {
    shift_key = ((shift_key % ALPHABET_LENGTH) + ALPHABET_LENGTH) % ALPHABET_LENGTH;
    size_t len = strlen(text);
    char* deciphered = malloc((len + 1) * sizeof(char));
    
    if (!deciphered) {
        fprintf(stderr, "Error: malloc failed\n");
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; i < len; i++) {
        char c = text[i];
        if (islower(c)) {
            deciphered[i] = rotate_lowercase(c, shift_key);
            continue;
        }
        if (isupper(c)) {
            deciphered[i] = rotate_uppercase(c, shift_key);
            continue;
        }
        deciphered[i] = c;
    }

    deciphered[len] = '\0';
    return deciphered;
}
