#include "gigasecond.h"

#define GIGASECOND 1e9

void gigasecond(time_t input, char* output, size_t size) {
    time_t time = input + GIGASECOND;
    strftime(output, size, "%F %T", gmtime(&time));
}
