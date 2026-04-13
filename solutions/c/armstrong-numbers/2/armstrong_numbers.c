#include "armstrong_numbers.h"
#include <math.h>
#include <stdlib.h>

static inline int count_digits(size_t number) {
    return number ? 1 + (int)floor(log10(number)) : 1;
}

static inline size_t size_pow(size_t base, size_t exponent) {
    size_t result = 1;

    while (exponent > 1) {
        size_t multiplier = 1;
        if (exponent & 1) multiplier = base;
        result *= multiplier;
        base *= base;
        exponent >>= 1;
    }
    return base * result;
}

bool is_armstrong_number(size_t candidate) {
    if (candidate < 10) return true;
    size_t digit_count = count_digits(candidate);
    size_t working_number = candidate;
    size_t armstrong_sum = 0;

    while (working_number > 0) {
        lldiv_t digit = lldiv(working_number, 10);
        size_t current_digit = digit.rem;

        armstrong_sum += size_pow(current_digit, digit_count);
        working_number = digit.quot;
    }

    return armstrong_sum == candidate;
}
