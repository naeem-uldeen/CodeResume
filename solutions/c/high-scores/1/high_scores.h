#ifndef HIGH_SCORES_H
#define HIGH_SCORES_H

#include <stddef.h>
#include <stdint.h>

int32_t latest(const int32_t* scores, size_t scores_len);

int32_t personal_best(const int32_t* scores, size_t scores_len);

size_t personal_top_three(const int32_t* scores, size_t scores_len, int32_t* output);

#endif
