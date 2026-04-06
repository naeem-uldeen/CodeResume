#include "binary.h"

int convert(const char* bin) {
    int result = 0;
    
    while (*bin) {
        char bit = *bin;
        if (bit != '0' && bit != '1') {
            return INVALID;
        }
        result = 2 * result + (bit - '0');
        bin++;
    }
    
    return result;
}
