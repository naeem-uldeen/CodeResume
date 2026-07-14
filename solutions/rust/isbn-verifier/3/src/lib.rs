pub fn is_valid_isbn(isbn: &str) -> bool {
    fn weight(index: usize) -> u32 { 10 - index as u32 }
    fn char_value(index: usize, digit: char) -> Option<u32> {
        match digit {
            '0'..='9' if index <= 9 => digit.to_digit(10),
            'X' if index == 9 => Some(10),
            _ => None,
        }
    }
    
    let mut count = 0;
    
    isbn.chars()
        .filter(|&c| c != '-')
        .enumerate()
        .try_fold(0, |checksum, (index, digit)| {
            char_value(index, digit).map(|value| {
                count += 1;
                checksum + value * weight(index)
            })
        }).is_some_and(|checksum| count == 10 && checksum.is_multiple_of(11))
}
