#include "gigasecond.h"

void gigasecond(time_t input, char* output, size_t size) {
    static const time_t GIGASECOND = 1e9;
    time_t time = input + GIGASECOND;
    
    strftime(output, size, "%F %T", gmtime(&time));
}
