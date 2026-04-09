#include "space_age.h"
#include "space_age.h"

#define EARTH_YEAR_IN_SECONDS 31557600.0f

static const float planet_years_per_second[] = {
    1.0f / (0.2408467f   * EARTH_YEAR_IN_SECONDS), // Mercury
    1.0f / (0.61519726f  * EARTH_YEAR_IN_SECONDS), // Venus
    1.0f / (1.0f         * EARTH_YEAR_IN_SECONDS), // Earth
    1.0f / (1.8808158f   * EARTH_YEAR_IN_SECONDS), // Mars
    1.0f / (11.862615f   * EARTH_YEAR_IN_SECONDS), // Jupiter
    1.0f / (29.447498f   * EARTH_YEAR_IN_SECONDS), // Saturn
    1.0f / (84.016846f   * EARTH_YEAR_IN_SECONDS), // Uranus
    1.0f / (164.79132f   * EARTH_YEAR_IN_SECONDS), // Neptune
};

float age(planet_t planet, int64_t seconds) {
    if (planet < MERCURY || planet > NEPTUNE) return -1.0f;
    return seconds * planet_years_per_second[planet];
}
