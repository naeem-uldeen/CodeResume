#include "beer_song.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define BOTTLES_AFTER_RESTOCK  99
#define WALL_SIZE              32
#define LINE_SIZE              128

static const char* WALL_EMPTY   = "no more bottles of beer";
static const char* WALL_LAST    = "1 bottle of beer";
static const char* WALL_COUNT   = "%d bottles of beer";

static const char* SHELF_EMPTY  = "No more bottles of beer on the wall, no more bottles of beer.";
static const char* SHELF_STATUS = "%s on the wall, %s.";
static const char* RESTOCK      = "Go to the store and buy some more, %s on the wall.";
static const char* PASS_AROUND  = "Take %s down and pass it around, %s on the wall.";

static const char* LAST_PRONOUN = "it";
static const char* STD_PRONOUN  = "one";

static void make_wall_str(uint8_t on_wall, char* out) {
    snprintf(out, WALL_SIZE,
             on_wall == 0 ? WALL_EMPTY :
             on_wall == 1 ? WALL_LAST : WALL_COUNT,
             on_wall);
}

static uint8_t after_passing(uint8_t on_wall) {
    return on_wall > 0 ? on_wall - 1 : BOTTLES_AFTER_RESTOCK;
}

static void compose_verse(uint8_t on_wall, uint8_t after,
                          char* shelf_out, char* action_out) {
    char wall_str[WALL_SIZE];
    char after_str[WALL_SIZE];

    make_wall_str(on_wall, wall_str);
    make_wall_str(after,   after_str);

    if (on_wall == 0) {
        strncpy(shelf_out, SHELF_EMPTY, LINE_SIZE);
        snprintf(action_out, LINE_SIZE, RESTOCK, after_str);
    } else {
        snprintf(shelf_out,  LINE_SIZE, SHELF_STATUS, wall_str, wall_str);
        snprintf(action_out, LINE_SIZE, PASS_AROUND,
                 on_wall == 1 ? LAST_PRONOUN : STD_PRONOUN,
                 after_str);
    }
}

void recite(uint8_t opening_count, uint8_t verse_count, char** song_lines) {
    uint8_t on_wall        = opening_count;
    int     line_index     = 0;
    bool    is_first_verse = true;

    for (uint8_t verses_left = verse_count; verses_left > 0; verses_left--) {
        uint8_t after = after_passing(on_wall);

        if (!is_first_verse)
            strcpy(song_lines[line_index++], "");

        is_first_verse = false;

        compose_verse(on_wall, after,
                      song_lines[line_index], song_lines[line_index + 1]);

        line_index += 2;
        on_wall     = after;
    }
}
