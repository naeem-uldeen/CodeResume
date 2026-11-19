static SCORES: [u64; 26] = [
    1, 3, 3, 2, 1, 4, 2, 4, 1,
    8, 5, 1, 3, 1, 1, 3, 10, 1,
    1, 1, 1, 4, 4, 8, 4, 10,
];

pub fn score(word: &str) -> u64 {
    word.chars()
        .filter(char::is_ascii_alphabetic)
        .map(|tile| SCORES[(tile.to_ascii_lowercase() as u8 - b'a') as usize])
        .sum()
}
