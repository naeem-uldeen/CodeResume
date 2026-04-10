#include "pangram.h"
#include <string.h>
#include <ctype.h>

#define ALPHABET_SIZE 26

bool is_pangram(const char* sentence) {
    if(!sentence) return false;

    bool seen[ALPHABET_SIZE] = {false};
    size_t sentence_len = strlen(sentence);

    for(size_t i = 0; i < sentence_len; i++) {
        const char letter = tolower((unsigned char)sentence[i]);
        if(letter >= 'a' && letter <= 'z') {
            seen[letter - 'a'] = true;
        }
    }

    for(size_t i = 0; i < ALPHABET_SIZE; i++) {
        if(!seen[i]) return false;
    }

    return true;
}