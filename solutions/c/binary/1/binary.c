#include "binary.h"

int convert(const char* bin) {
    int result = 0;
    int length = strlen(bin);
    for (int i = 0; i < length; ++i) {
        char bit = bin[i];
        if (bit != '0' && bit != '1') {
            return INVALID;
        }
        result = 2 * result + (bit - '0');
    }
    return result;
}
