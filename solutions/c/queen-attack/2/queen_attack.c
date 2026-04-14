#include "queen_attack.h"
#include <stdlib.h>

#define SAME_ROW(white, black)     ((white).row == (black).row)
#define SAME_COL(white, black)     ((white).column == (black).column)
#define SAME_SQUARE(white, black)  (SAME_ROW(white, black) && SAME_COL(white, black))
#define SAME_DIAG(white, black)    (abs((white).row - (black).row) == abs((white).column - (black).column))
#define OFF_BOARD(position)        ((position).row > 7 || (position).column > 7)

attack_status_t can_attack(position_t white, position_t black) {
    if (OFF_BOARD(white) || OFF_BOARD(black) || SAME_SQUARE(white, black))
        return INVALID_POSITION;
    if (SAME_ROW(white, black) || SAME_COL(white, black) || SAME_DIAG(white, black))
        return CAN_ATTACK;
    
    return CAN_NOT_ATTACK;
}
