#include "collatz_conjecture.h"
#include <stdexcept>

namespace collatz_conjecture {

    unsigned int steps(int n) {
        if (n < 1) {
            throw std::domain_error("value must be positive");
        }
        unsigned int steps = 0;

        while (n > 1) {
            n % 2 == 0 ? n /= 2 : n = n * 3 + 1;
            steps += 1;
        }

        return steps;
    }

}
