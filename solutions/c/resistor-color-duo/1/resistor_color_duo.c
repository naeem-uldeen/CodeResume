#include "resistor_color_duo.h"

uint16_t color_code(resistor_band_t bands[]) {
    uint16_t tensDigit = bands[0];
    uint16_t onesDigit = bands[1];
    
    return tensDigit * 10 + onesDigit;
}
