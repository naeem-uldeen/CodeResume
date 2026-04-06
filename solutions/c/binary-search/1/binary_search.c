#include "binary_search.h"

const int *binary_search(int target, const int* sorted_items, size_t length) {
    int low = 0;
    int high = length - 1;

    while (low <= high) {
        //prevents overflow when adding two large integers.
        int mid = ((unsigned int)low + (unsigned int)high) >> 1;
        if (sorted_items[mid] == target)
            return &sorted_items[mid];

        if (target < sorted_items[mid]) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return NULL;
}
