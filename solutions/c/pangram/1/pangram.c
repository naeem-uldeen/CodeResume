#include "pangram.h"
#include "pangram.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>

bool is_pangram(const char* sentence) {
    if(!sentence) return false;
    const char* alphabet = "abcdefghijklmnopqrstuvwxyz";

    for(size_t i = 0; i < strlen(alphabet); i++) {
        char letter = *(alphabet + i);
        char upcased_letter = toupper(*(alphabet + i));

        if(strchr(sentence, letter) == NULL &&
           strchr(sentence, upcased_letter) == NULL) {
            return false;
        } else {
            continue;
        }
     }
     return true;
}
