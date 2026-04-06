#include "hamming.h"
#include <stdio.h>
#include <string.h>
#define ERROR -1

int compute(const char* strand_a, const char* strand_b) {
    size_t length_a = strlen(strand_a);
    size_t length_b = strlen(strand_b);
    if(length_a != length_b) return ERROR;
    size_t hamming_distance = 0;

    for(size_t i = 0; i < length_a; i++) {
        if(*(strand_a + i) != *(strand_b + i)) {
            hamming_distance++;
        }
    }
    return hamming_distance;
}
