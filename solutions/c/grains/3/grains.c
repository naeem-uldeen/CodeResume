#include "grains.h"

static const uint8_t SQUARES_COUNT = 64;

uint64_t square(uint8_t index) {
    if (index < 1 || index > SQUARES_COUNT) {
        return 0;
    }
    return 1ULL << (index - 1);
}

uint64_t total(void) {
    // 2^64 - 1 = UINT64_MAX
    return square(SQUARES_COUNT) * 2 - 1;
}
