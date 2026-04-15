#include "queen_attack.h"
#include <stdlib.h>

#define BOARD_SIZE 8

attack_status_t can_attack(position_t white, position_t black) {
    // The max of unsigned ints >= 8 iff their bitwise OR >= 8
    if ((white.row | white.column | black.row | black.column) >= BOARD_SIZE)
        return INVALID_POSITION;

    unsigned int row_diff    = white.row - black.row;
    unsigned int column_diff = white.column - black.column;

    if (row_diff == 0 && column_diff == 0)
        return INVALID_POSITION;

    if (row_diff == 0 || column_diff == 0 ||
        abs((int)row_diff) == abs((int)column_diff))
        return CAN_ATTACK;

    return CAN_NOT_ATTACK;
}
