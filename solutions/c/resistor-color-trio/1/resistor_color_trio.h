#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

#include <stdint.h>

typedef enum {
    GIGAOHMS,
    MEGAOHMS,
    KILOOHMS,
    OHMS
} ohms_unit;

typedef enum {
    BLACK,
    BROWN,
    RED,
    ORANGE,
    YELLOW,
    GREEN,
    BLUE,
    VIOLET,
    GREY,
    WHITE
} resistor_band_t;

typedef struct {
    int value;
    ohms_unit unit;
} resistor_value_t;

resistor_value_t color_code(resistor_band_t* resistor_color);

#endif
