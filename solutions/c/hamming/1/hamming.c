#include "hamming.h"
#include <stdio.h>
#include <string.h>

int compute(const char* strand_a, const char* strand_b) {
    if(strlen(strand_a) != strlen(strand_b)) return -1;
    int hamming_distance = 0;
    
    for(size_t i = 0; i < strlen(strand_a); i++) {
        if(*(strand_a + i) != *(strand_b + i)) {
            hamming_distance++;
        }  
    }
    return hamming_distance;
}
