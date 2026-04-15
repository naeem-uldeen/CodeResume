#include "high_scores.h"
#include <stdint.h>
#include <stddef.h>
#include <limits.h>

int32_t latest(const int32_t* scores, size_t scores_len) {
    return scores[scores_len - 1];
}

size_t personal_top_three(const int32_t* scores, size_t scores_len, int32_t* output) {
    int32_t top[3] = {INT32_MIN, INT32_MIN, INT32_MIN};

    for (size_t i = 0; i < scores_len; i++) {
        int32_t score = scores[i];
        
        if (score > top[0]) {
            top[2] = top[1];
            top[1] = top[0];
            top[0] = score;
        } else if (score > top[1]) {
            top[2] = top[1];
            top[1] = score;
        } else if (score > top[2]) {
            top[2] = score;
        }
    }

    size_t n = scores_len < 3 ? scores_len : 3;
    for (size_t i = 0; i < n; i++) {
        output[i] = top[i];
    }
    return n;
}

int32_t personal_best(const int32_t* scores, size_t scores_len) {
    int32_t top[3];
    personal_top_three(scores, scores_len, top);
    return top[0];
}
