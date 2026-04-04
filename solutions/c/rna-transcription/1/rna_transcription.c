#include "rna_transcription.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char dna;
    char rna;
} DNA_RNA;

static const DNA_RNA map[] = {
    { 'G', 'C' },
    { 'C', 'G' },
    { 'T', 'A' },
    { 'A', 'U' },
};
static const int MAP_SIZE = sizeof(map) / sizeof(map[0]);

static char map_get(char dna) {
    for (int i = 0; i < MAP_SIZE; i++)
        if (map[i].dna == dna)
            return map[i].rna;
    return '\0';
}

char *to_rna(const char *dna) {
    size_t len = strlen(dna);
    char *rna = malloc(len + 1);

    for (size_t i = 0; i < len; i++) {
        rna[i] = map_get(dna[i]);
    }

    rna[len] = '\0';
    return rna;
}
