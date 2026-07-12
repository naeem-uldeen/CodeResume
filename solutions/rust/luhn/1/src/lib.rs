pub fn is_valid(code: &str) -> bool {
    let reversed_code: Vec<char> = code
        .chars()
        .rev()
        .filter(|c| !c.is_whitespace())
        .collect();
    if reversed_code.len() < 2 { return false; }
    fn double_up(n: u32) -> u32 { n * 2 }
    fn result_of_doubling_greater_than_nine(n: u32) -> bool { n > 4 }
    fn subtract_nine(n: u32) -> u32 { n - 9 }
    let mut checksum = 0;
    let mut second_digit = false;
    
    for digit in reversed_code {
        let mut number: u32 = match digit.to_digit(10) {
            Some(n) => n,
            None => return false,
        };
        if second_digit {
            let should_subtract = result_of_doubling_greater_than_nine(number);
            number = double_up(number);
            if should_subtract {
                number = subtract_nine(number);
            }
        }
        checksum += number;
        second_digit = !second_digit;
    }

    checksum % 10 == 0
}
