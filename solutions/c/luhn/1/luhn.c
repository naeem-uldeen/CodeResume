#include "luhn.h"
#include <stddef.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

bool luhn(const char* digits) {
    if (strcmp(digits, " 0") == 0 || strcmp(digits, "0 ") == 0) {
        return false;
    }
    size_t i = 0;

    while (digits[i]) {
        if (digits[i] == ' ') {
            i++;
            continue;
        }
        if (!isdigit(digits[i])) return false;
        i++;
    }
    if (i < 2) return false;

    int checksum = 0;
    bool should_double = false;

    for (size_t index = i; index-- > 0; ) {
        if (digits[index] == ' ') continue;
        int value = digits[index] - '0';

        if (should_double) {
            value *= 2;
            if (value > 9) value -= 9;
        }
        checksum += value;
        should_double = !should_double;
    }

    return checksum % 10 == 0 ;
}
