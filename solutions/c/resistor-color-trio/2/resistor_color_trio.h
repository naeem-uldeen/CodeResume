#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

#include <stdint.h>

#define RESISTOR_COLORS \
    BLACK, \
    BROWN, \
    RED, \
    ORANGE, \
    YELLOW, \
    GREEN, \
    BLUE, \
    VIOLET, \
    GREY, \
    WHITE

#define OHMS_UNITS \
    OHMS, \
    KILOOHMS, \
    MEGAOHMS, \
    GIGAOHMS

typedef enum { RESISTOR_COLORS } resistor_band_t;
typedef enum { OHMS_UNITS } ohms_unit;

typedef struct {
    int value;
    ohms_unit unit;
} resistor_value_t;

resistor_value_t color_code(resistor_band_t resistor_color[]);

#endif
