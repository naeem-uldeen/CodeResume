use std::collections::HashMap;

pub fn score(word: &str) -> u64 {
    let mut scores = HashMap::new();
    for c in ['a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't'] {
        scores.insert(c, 1);
    }
    for c in ['d', 'g'] {
        scores.insert(c, 2);
    }
    for c in ['b', 'c', 'm', 'p'] {
        scores.insert(c, 3);
    }
    for c in ['f', 'h', 'v', 'w', 'y'] {
        scores.insert(c, 4);
    }
    scores.insert('k', 5);
    for c in ['j', 'x'] {
        scores.insert(c, 8);
    }
    for c in ['q', 'z'] {
        scores.insert(c, 10);
    }

    let mut total = 0;
    let tiles_to_score = word.to_lowercase();

    for tile in tiles_to_score.chars() {
        total += scores.get(&tile).unwrap_or(&0);
    }

    total
}
