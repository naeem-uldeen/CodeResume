#include "nucleotide_count.h"

char* count(const char* dna_strand) {
    char* formatted_counts = malloc(100 * sizeof(char));
    int64_t a_count = 0, c_count = 0, g_count = 0, t_count = 0;
    
    while (*dna_strand) {
        char nucleotide = toupper(*dna_strand);
        
        switch (nucleotide) {
            case 'A': a_count++;
                break;
            case 'C': c_count++;
                break;
            case 'G': g_count++;
                break;
            case 'T': t_count++;
                break;
                
            default:
                strcpy(formatted_counts, "");
                return formatted_counts;
        }
        dna_strand++;
    }
    // Using snprintf returns a failure indication if the result doesn't fit.
    int n = snprintf(formatted_counts, 100, "A:%ld C:%ld G:%ld T:%ld", a_count, c_count, g_count, t_count);
    
    if (n >= 100) {
        snprintf(formatted_counts, 100, "Error: Output truncated, counts too large");
        free(formatted_counts);
        return NULL;
    }
    return formatted_counts;
}
