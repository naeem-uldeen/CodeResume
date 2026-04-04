#include "rna_transcription.h"
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

char switch_get(char character) {
    switch (character) {
        case 'G': return 'C';
        case 'C': return 'G';
        case 'T': return 'A';
        case 'A': return 'U';
        default:  return '\0';
    }
}

char* to_rna(const char* dna) {
    size_t len = strlen(dna);
    char* rna = malloc(len + 1);

    for (size_t i = 0; i < len; i++) {
        rna[i] = switch_get(dna[i]);
    }

    rna[len] = '\0';
    return rna;
}
