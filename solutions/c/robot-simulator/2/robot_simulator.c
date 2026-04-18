#include "robot_simulator.h"

#define DX 0
#define DY 1

#define NORTH { 0,  1}
#define EAST  { 1,  0}
#define SOUTH { 0, -1}
#define WEST  {-1,  0}

static const int DELTA[4][2] = {
    NORTH,
    EAST,
    SOUTH,
    WEST
};

robot_status_t robot_create(robot_direction_t direction, int x, int y) {
    return (robot_status_t){ direction, { x, y } };
}

void robot_move(robot_status_t* robot, const char* commands) {
    while (*commands) {
        switch (*commands++) {
            case 'R':
                robot->direction = (robot->direction + 1) % DIRECTION_MAX;
                break;
            case 'L':
                robot->direction = (robot->direction + DIRECTION_MAX - 1) % DIRECTION_MAX;
                break;
            case 'A':
                robot->position.x += DELTA[robot->direction][DX];
                robot->position.y += DELTA[robot->direction][DY];
                break;
        }
    }
}
