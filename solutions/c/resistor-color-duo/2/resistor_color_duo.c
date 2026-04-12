#include "resistor_color_duo.h"

uint16_t color_code(resistor_band_t band[]) {
    return band[0] * 10 + band[1];
}
