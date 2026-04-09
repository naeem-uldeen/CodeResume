#ifndef LUHN_H
#define LUHN_H

#include <stddef.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

bool luhn(const char* digits);

#endif
