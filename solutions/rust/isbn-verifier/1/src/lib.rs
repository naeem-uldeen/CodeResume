pub fn is_valid_isbn(isbn: &str) -> bool {
    let isbn: Vec<char> = isbn.chars().filter(|&c| c != '-').collect();
    if isbn.len() != 10 { return false; }
    let first_nine = isbn.iter().take(9);
    let checkchar = isbn[9];
    if !checkchar.is_ascii_digit() && checkchar != 'X' {
        return false;
    }
    let mut checksum = 0;

    for (index, &digit) in first_nine.enumerate() {
        match digit {
            '0'..='9' => {
                let weight = 10 - index;
                checksum += digit.to_digit(10).unwrap() * weight as u32;
            }
            _ => return false,
        }
    }

    if checkchar == 'X' {
        checksum += 10;
    } else {
        checksum += checkchar.to_digit(10).unwrap();
    }
    checksum % 11 == 0
}
