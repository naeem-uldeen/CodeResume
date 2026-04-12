#include "triangle.h"

static bool is_triangle(const triangle_t sides) {
    return sides.a > 0 && sides.b > 0 && sides.c > 0 &&
           sides.a + sides.b > sides.c &&
           sides.a + sides.c > sides.b &&
           sides.b + sides.c > sides.a;
}

static bool is_isosceles_real(const triangle_t sides) {
    return sides.a == sides.b ||
           sides.b == sides.c ||
           sides.a == sides.c;
}

static bool all_sides_equal(const triangle_t sides) {
    return sides.a == sides.b && sides.b == sides.c;
}

bool is_equilateral(const triangle_t sides) {
    return is_triangle(sides) && all_sides_equal(sides);

}

bool is_isosceles(const triangle_t sides) {
    return is_triangle(sides) && is_isosceles_real(sides);
}

bool is_scalene(const triangle_t sides) {
    return is_triangle(sides) && !is_isosceles_real(sides);
}
