#include "isogram.h"
#include <ctype.h>
#include <stdint.h>

bool is_isogram(const char* phrase) {
    if (!phrase) return false;
    uint32_t seen = 0;

    for (; *phrase; phrase++) {
        if (!isalpha(*phrase)) continue;
        int bit = 1 << (tolower(*phrase) - 'a');
        if (seen & bit) return false;
        seen |= bit;
    }
    return true;
}
