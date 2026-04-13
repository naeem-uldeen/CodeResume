#include "darts.h"
#include <math.h>

static const uint8_t inner_circle  = 10;
static const uint8_t middle_circle = 5;
static const uint8_t outer_circle  = 1;
static const uint8_t missed        = 0;

static inline float squared_distance(coordinate_t impact) {
    return impact.x * impact.x + impact.y * impact.y;
}

uint8_t score(coordinate_t impact) {
    float distance_squared = squared_distance(impact);
    if      (distance_squared <= 1.0f)   return inner_circle;
    else if (distance_squared <= 25.0f)  return middle_circle;
    else if (distance_squared <= 100.0f) return outer_circle;
    else                                 return missed;
}
