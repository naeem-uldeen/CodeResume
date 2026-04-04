#include "isogram.h"
#include <ctype.h>
#include <stdint.h>

bool is_isogram(const char* phrase) {
    if (!phrase) return false;
    uint32_t seen = 0;

    for(; *phrase; phrase++) {
        unsigned char character = tolower(*phrase) - 'a';
        uint32_t bit = 0;

        if (character <= 25) bit = 1u << character;
        if (seen & bit) return false;

        seen |= bit;
    }
    return true;
}
