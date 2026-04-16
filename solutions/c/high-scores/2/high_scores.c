#include "high_scores.h"
#include <stdint.h>
#include <stddef.h>
#include <limits.h>

int32_t latest(const int32_t* scores, size_t scores_len) {
    return scores[scores_len - 1];
}

int32_t personal_best(const int32_t* scores, size_t scores_len) {
    int32_t best = INT32_MIN;
    for (size_t i = 0; i < scores_len; i++) {
        if (scores[i] > best)
            best = scores[i];
    }
    return best;
}

size_t personal_top_three(const int32_t* scores, size_t scores_len, int32_t* output) {
    output[0] = output[1] = output[2] = INT32_MIN;

    for (size_t i = 0; i < scores_len; i++) {
        int32_t score = scores[i];

        if (score <= output[2])
            continue;
        if (score <= output[1]) {
            output[2] = score;
            continue;
        }
        if (score <= output[0]) {
            output[2] = output[1];
            output[1] = score;
            continue;
        }
        output[2] = output[1];
        output[1] = output[0];
        output[0] = score;
    }

    return scores_len < 3 ? scores_len : 3;
}
