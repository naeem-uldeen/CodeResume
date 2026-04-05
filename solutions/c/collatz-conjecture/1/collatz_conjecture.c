#include "collatz_conjecture.h"

int steps(int number) {
    if (number <= 0) return ERROR_VALUE;
    int steps = 0;
    
    while (number > 1) {
        if (number % 2 == 0) number /= 2;
        else number = 3 * number + 1;
        steps++;
    } 
        
    return steps;
}
