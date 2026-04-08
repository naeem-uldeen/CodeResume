#include "space_age.h"

#define EARTH_ORBITAL_PERIOD_SECONDS 31557600.0
#define MERCURY_ORBITAL_PERIOD 0.2408467
#define VENUS_ORBITAL_PERIOD 0.61519726
#define EARTH_ORBITAL_PERIOD 1.0
#define MARS_ORBITAL_PERIOD 1.8808158
#define JUPITER_ORBITAL_PERIOD 11.862615
#define SATURN_ORBITAL_PERIOD 29.447498
#define URANUS_ORBITAL_PERIOD 84.016846
#define NEPTUNE_ORBITAL_PERIOD 164.79132

float age(planet_t planet, int64_t seconds) {
    const float ORBITAL_PERIODS[] = {
        MERCURY_ORBITAL_PERIOD,
        VENUS_ORBITAL_PERIOD,
        EARTH_ORBITAL_PERIOD,
        MARS_ORBITAL_PERIOD,
        JUPITER_ORBITAL_PERIOD,
        SATURN_ORBITAL_PERIOD,
        URANUS_ORBITAL_PERIOD,
        NEPTUNE_ORBITAL_PERIOD
    };
    if (planet < MERCURY || planet > NEPTUNE) {
        return -1.0;
    }
    float planet_orbital_period = ORBITAL_PERIODS[planet];
    float age_on_planet = seconds / (EARTH_ORBITAL_PERIOD_SECONDS * planet_orbital_period);
    
    return age_on_planet;
}

