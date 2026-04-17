#include "dnd_character.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>

#define DICE 4
#define SIDES 6
#define MODIFIER 10
#define HITPOINTS 10

int ability(void) {
    int sum = 0;
    int min = SIDES + 1;
    
    for (int i = 0; i < DICE; i++) {
        int roll = (rand() % SIDES) + 1;
        if (roll < min) min = roll;
        sum += roll;
    }
    
    return sum - min;
}

int modifier(int score) {
    return (int)floor((score - MODIFIER) / 2.0);
}

dnd_character_t make_dnd_character(void) {
    srand(time(NULL));
    dnd_character_t character = {0};

    character.strength     = ability();
    character.dexterity    = ability();
    character.constitution = ability();
    character.intelligence = ability();
    character.wisdom       = ability();
    character.charisma     = ability();
    character.hitpoints    = HITPOINTS + modifier(character.constitution);

    return character;
}
