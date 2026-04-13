#include "grains.h"

static const uint8_t SQUARES_COUNT = 64;

uint64_t square(uint8_t index) {
    if (index < 1 || index > SQUARES_COUNT) {
        return 0;
    }
    return 1ULL << (index - 1);
}

uint64_t total(void) {
    return UINT64_MAX;
}
