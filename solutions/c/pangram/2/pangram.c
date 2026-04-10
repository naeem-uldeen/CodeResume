#include "pangram.h"

#include <string.h>
#include <ctype.h>

bool is_pangram(const char* sentence) {
    if(!sentence) return false;
    const char* alphabet = "abcdefghijklmnopqrstuvwxyz";
    size_t alphabet_length = strlen(alphabet);

    for(size_t i = 0; i < alphabet_length; i++) {
        const char letter = alphabet[i];
        const char upcased_letter = toupper(alphabet[i]);

        if(strchr(sentence, letter) == NULL &&
           strchr(sentence, upcased_letter) == NULL) {
            return false;
        }
    }
    return true;
}
