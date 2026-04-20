#include "sum_of_multiples.h"
#include <stdbool.h>
#include <stdlib.h>

uint sum(const uint* factors, const size_t size, const uint limit) {
    if (limit == 0) return 0;
    bool* seen = calloc(limit, sizeof(bool));
    if (!seen) return 0;

    uint result = 0;

    for (size_t i = 0; i < size; i++) {
        uint factor = factors[i];
        if (factor == 0) continue;

        for (uint number = 1; number < limit; number++) {
            if (number % factor == 0 && !seen[number]) {
                seen[number] = true;
                result += number;
            }
        }
    }

    free(seen);
    return result;
}
