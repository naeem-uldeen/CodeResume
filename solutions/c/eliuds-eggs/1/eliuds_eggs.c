#include "eliuds_eggs.h"

int egg_count(int number) {
    int count = 0;
    while (number != 0) {
        number &= number - 1;
        count += 1;
    }
    return count;
}
