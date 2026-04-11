#include "triangle.h"

bool is_triangle(triangle_t sides) {
    return sides.a > 0 && sides.b > 0 && sides.c > 0 &&
           sides.a + sides.b > sides.c &&
           sides.a + sides.c > sides.b &&
           sides.b + sides.c > sides.a;
}

bool is_equilateral(triangle_t sides) {
    if (!is_triangle(sides)) return false;
    return sides.a == sides.b && sides.b == sides.c;
}

bool is_scalene(triangle_t sides) {
    if (!is_triangle(sides)) return false;
    return sides.a != sides.b &&
           sides.b != sides.c &&
           sides.a != sides.c;
}

bool is_isosceles(triangle_t sides) {
    if (!is_triangle(sides)) return false;
    return sides.a == sides.b ||
           sides.b == sides.c ||
           sides.a == sides.c;
}
