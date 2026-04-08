#include "luhn.h"
#include <stddef.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

bool luhn(const char* digits) {
    size_t digit_count = 0;

    for (size_t j = 0; digits[j]; j++) {
        if (isdigit(digits[j])) {
            digit_count++;
            continue;
        }
        if (digits[j] == ' ') {
            continue;
        }
        return false;
    }
    if (digit_count < 2) return false;

    size_t i = strlen(digits);

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

    return checksum % 10 == 0;
}
