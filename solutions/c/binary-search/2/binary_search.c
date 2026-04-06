#include "binary_search.h"

const int* binary_search(int target, const int* sorted_items, size_t length) {
    if (length == 0) return NULL;

    size_t low = 0;
    size_t high = length - 1;

    while (low <= high) {
        size_t mid = low + (high - low) / 2;

        if (sorted_items[mid] == target)
            return &sorted_items[mid];

        if (target < sorted_items[mid]) {
            if (mid == 0) return NULL;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return NULL;
}
