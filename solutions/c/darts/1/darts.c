#include "darts.h"
#include <math.h>

static const uint8_t inner_circle  = 10;
static const uint8_t middle_circle = 5;
static const uint8_t outer_circle  = 1;
static const uint8_t missed        = 0;

static inline float distance_from_center(coordinate_t impact) {
    return sqrtf(impact.x * impact.x + impact.y * impact.y);
}

uint8_t score(coordinate_t impact) {
    float distance = distance_from_center(impact);
    if (distance <= 1.0f)       return inner_circle;
    else if (distance <= 5.0f)  return middle_circle;
    else if (distance <= 10.0f) return outer_circle;
    else                        return missed;
}
