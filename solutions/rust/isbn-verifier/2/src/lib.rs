pub fn is_valid_isbn(isbn: &str) -> bool {
    let isbn: Vec<char> = isbn.chars().filter(|&c| c != '-').collect();
    if isbn.len() != 10 { return false; }
    fn weight(index: usize) -> u32 { 10 - index as u32 }
    fn char_value(digit: char) -> Option<u32> {
        match digit {
            '0'..='9' => digit.to_digit(10),
            'X' => Some(10),
            _ => None,
        }
    }
    let mut checksum = 0;

    for (index, &digit) in isbn.iter().enumerate() {
        let value = match char_value(digit) {
            Some(value) if index == 9 || digit != 'X' => value,
            _ => return false,
        };
        checksum += value * weight(index);
    }

    checksum % 11 == 0
}
