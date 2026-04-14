#include "queen_attack.h"

#include <stdbool.h>
#include <stdlib.h>

static bool queens_occupy_same_square(position_t white, position_t black);
static bool queens_occupy_same_row(position_t white, position_t black);
static bool queens_occupy_same_column(position_t white, position_t black);
static bool queens_occupy_same_diagonal(position_t white, position_t black);
static bool off_board_row_number(position_t white, position_t black);
static bool off_board_column_number(position_t white, position_t black);

attack_status_t can_attack(position_t white, position_t black) {
    if (off_board_row_number(white, black)    ||
        off_board_column_number(white, black) ||
        queens_occupy_same_square(white, black))
    return INVALID_POSITION;

    if (queens_occupy_same_row(white, black)    ||
        queens_occupy_same_column(white, black) ||
        queens_occupy_same_diagonal(white, black))
    return CAN_ATTACK;

    return CAN_NOT_ATTACK;
}


static bool queens_occupy_same_square(position_t white, position_t black) {
    return white.row == black.row && white.column == black.column;
}

static bool queens_occupy_same_row(position_t white, position_t black) {
    return white.row == black.row;
}

static bool queens_occupy_same_column(position_t white, position_t black) {
    return white.column == black.column;
}

static bool queens_occupy_same_diagonal(position_t white, position_t black) {
    return abs(white.row - black.row) == abs(white.column - black.column);
}

static bool off_board_row_number(position_t white, position_t black) {
    return white.row > 7 || black.row > 7;
}

static bool off_board_column_number(position_t white, position_t black) {
    return white.column > 7 || black.column > 7;
}
