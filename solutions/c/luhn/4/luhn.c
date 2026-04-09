#include "luhn.h"

static bool strip(const char* digits, size_t raw_len, char* out, size_t* out_len);
static bool validate(const char* stripped, size_t len);

bool luhn(const char* digits) {
    size_t raw_len = strlen(digits);
    char* stripped = malloc(raw_len + 1);

    if (!stripped) return false;

    size_t len = 0;
    bool valid = strip(digits, raw_len, stripped, &len)
                 && len >= 2
                 && validate(stripped, len);
    free(stripped);

    return valid;
}

static bool strip(const char* digits, size_t raw_len,
                  char* out, size_t* out_len) {
    *out_len = 0;
    for (size_t i = 0; i < raw_len; i++) {
        if (digits[i] == ' ') continue;
        if (!isdigit((unsigned char)digits[i])) return false;
        out[(*out_len)++] = digits[i];
    }
    return true;
}

static bool validate(const char* stripped, size_t len) {
    int checksum = 0;
    for (size_t i = len; i-- > 0; ) {
        int value = stripped[i] - '0';
        if ((len - 1 - i) % 2 == 1) {
            value *= 2;
            if (value > 9) value -= 9;
        }
        checksum += value;
    }
    return checksum % 10 == 0;
}
