#include "collatz_conjecture.h"
#include <cstdint>
#include <stdexcept>

namespace collatz_conjecture {

unsigned int steps(int n) {
    if (n < 1) {
        throw std::domain_error("value must be positive");
    }

    std::uint64_t value = static_cast<std::uint64_t>(n);
    unsigned int count = 0;

    while (value > 1) {
        if (value % 2 == 0) {
            value /= 2;
        } else {
            value = value * 3 + 1;
        }

        ++count;
    }

    return count;
}

}
