#include "luhn.h"
#include <stddef.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

bool luhn(const char* digits) {
    char stripped[strlen(digits) + 1];
    size_t len = 0;

    for (size_t i = 0; digits[i]; i++) {
        if (digits[i] == ' ') continue;
        if (!isdigit((unsigned char)digits[i])) return false;
        stripped[len++] = digits[i];
    }

    if (len < 2) return false;

    int checksum = 0;
    for (size_t i = len; i-- > 0; ) {
        int value = stripped[i] - '0';
        if ((len - 1 - i) % 2 == 1) {
            value *= 2;
            if (value > 9) value -= 9;
        }
        checksum += value;
    }

    return checksum % 10 == 0;
}
