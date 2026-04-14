#include "perfect_numbers.h"
#include <limits.h>

static size_t sum_factors(size_t number) {
    size_t factors_sum = 0;

    for (size_t i = 1; i <= number / i; i++) {
        if (number % i == 0) {
            factors_sum += i;
            size_t j = number / i;
            if (j != number && j != i) {
                factors_sum += j;
            }
        }
    }
    
    return factors_sum;
}

kind classify_number(size_t number) {
    if (number == 0 || number > (size_t)INT_MAX) return ERROR;
    if (number == 1) return DEFICIENT_NUMBER;

    size_t aliquot_sum = sum_factors(number);
    if (aliquot_sum > number) {
        return ABUNDANT_NUMBER;
    } else if (aliquot_sum < number) {
        return DEFICIENT_NUMBER;
    }
    
    return PERFECT_NUMBER;
}
