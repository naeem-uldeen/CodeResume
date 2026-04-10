#include "nucleotide_count.h"
#include <math.h>
#include <inttypes.h>

static int count_width(int64_t n) {
    if (n == 0) return 1;
    return (int)ceil(log10(n + 1.0));
}

char* count(const char* dna_strand) {
    int64_t a_count = 0, c_count = 0, g_count = 0, t_count = 0;

    for (const char* base_ptr = dna_strand; *base_ptr; base_ptr++) {
        char base = toupper(*base_ptr);
        switch (base) {
            case 'A': a_count++; break;
            case 'C': c_count++; break;
            case 'G': g_count++; break;
            case 'T': t_count++; break;
            default:
                return calloc(1, sizeof(char));
        }
    }

    int width = count_width(a_count) + count_width(c_count) +
                count_width(g_count) + count_width(t_count);
    
    int size = width + 12 + 1;
    
    char* formatted_counts = malloc(size * sizeof(char));

    if (formatted_counts) {
        snprintf(formatted_counts, size,
         "A:%"  PRId64
         " C:%" PRId64
         " G:%" PRId64
         " T:%" PRId64,
         a_count, c_count, g_count, t_count);
    }
    return formatted_counts;
}
