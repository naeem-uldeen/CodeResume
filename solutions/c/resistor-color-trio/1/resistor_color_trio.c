#include "resistor_color_trio.h"

#include <math.h>

resistor_value_t color_code(resistor_band_t* resistor_color) {
    resistor_value_t rv;
    uint64_t value = (resistor_color[0] * 10 + resistor_color[1]) *
        pow(10, resistor_color[2]);
    const uint64_t thresholds[] = {1000000000, 1000000, 1000, 1};
    const ohms_unit units[] = {GIGAOHMS, MEGAOHMS, KILOOHMS, OHMS};
    
    if (value == 0) {
        rv.value = 0;
        rv.unit = OHMS;
        return rv;
    }
    
    for (int i = 0; i < 4; ++i) {
        if (value >= thresholds[i]) {
            rv.value = value / thresholds[i];
            rv.unit = units[i];
            break;
        }
    }
    return rv;
}
