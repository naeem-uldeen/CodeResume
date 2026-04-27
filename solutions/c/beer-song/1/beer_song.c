#include "beer_song.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define FULL_STOCK      99
#define BOTTLE_BUF_SIZE 32
#define LINE_BUF_SIZE   128

static const char *NO_MORE_BOTTLES   = "no more bottles of beer";
static const char *ONE_BOTTLE        = "1 bottle of beer";
static const char *MANY_BOTTLES_FMT  = "%d bottles of beer";
static const char *LINE1_ZERO        = "No more bottles of beer on the wall, no more bottles of beer.";
static const char *LINE1_FMT         = "%s on the wall, %s.";
static const char *LINE2_ZERO_FMT    = "Go to the store and buy some more, %s on the wall.";
static const char *LINE2_FMT         = "Take %s down and pass it around, %s on the wall.";
static const char *TAKE_IT           = "it";
static const char *TAKE_ONE          = "one";

static void bottle_string(uint8_t number_of_bottles, char *buffer) {
    snprintf(buffer, BOTTLE_BUF_SIZE,
        number_of_bottles == 0 ? NO_MORE_BOTTLES :
        number_of_bottles == 1 ? ONE_BOTTLE : MANY_BOTTLES_FMT,
        number_of_bottles);
}

static uint8_t next_bottle_count(uint8_t current_bottles) {
    return current_bottles ? current_bottles - 1 : FULL_STOCK;
}

static void write_verse(uint8_t current_bottles, uint8_t remaining_bottles,
                        char *line1, char *line2) {
    char current_phrase[BOTTLE_BUF_SIZE];
    char next_phrase[BOTTLE_BUF_SIZE];
    bottle_string(current_bottles, current_phrase);
    bottle_string(remaining_bottles, next_phrase);

    if (current_bottles == 0) {
        strncpy(line1, LINE1_ZERO, LINE_BUF_SIZE);
        snprintf(line2, LINE_BUF_SIZE, LINE2_ZERO_FMT, next_phrase);
    } else {
        snprintf(line1, LINE_BUF_SIZE, LINE1_FMT, current_phrase, current_phrase);
        snprintf(line2, LINE_BUF_SIZE, LINE2_FMT,
            current_bottles == 1 ? TAKE_IT : TAKE_ONE, next_phrase);
    }
}

void recite(uint8_t start_bottles, uint8_t take_down, char **song) {
    uint8_t current_bottles = start_bottles;
    int current_line = 0;
    bool first_verse = true;

    for (uint8_t verse_count = take_down; verse_count > 0; verse_count--) {
        uint8_t remaining_bottles = next_bottle_count(current_bottles);

        if (!first_verse)
            strcpy(song[current_line++], "");
        first_verse = false;

        write_verse(current_bottles, remaining_bottles,
                    song[current_line], song[current_line + 1]);
        current_line += 2;
        current_bottles = remaining_bottles;
    }
}
