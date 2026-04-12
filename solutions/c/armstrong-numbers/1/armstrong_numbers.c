#include "armstrong_numbers.h"

bool is_armstrong_number(size_t candidate) {
    if (candidate < 10) return true;

    size_t working_number = candidate;
    size_t digit_count = 0;
    
    while (working_number > 0) { 
        digit_count++; 
        working_number /= 10; 
    }

    working_number = candidate;
    size_t armstrong_sum = 0;
    
    while (working_number > 0) {
        size_t current_digit = working_number % 10;
        size_t digit_raised_to_power = 1;
        
        for (size_t exponent = 0; exponent < digit_count; exponent++) {
            digit_raised_to_power *= current_digit;
        }
        
        armstrong_sum += digit_raised_to_power;
        working_number /= 10; 
    }

    return armstrong_sum == candidate;
}
