#include "resistor_color.h"

uint16_t color_code(resistor_band_t band_color) {
    return band_color;
}

const resistor_band_t* colors(void) {
    static const resistor_band_t colors[] = { COLORS };
    return colors;
}
