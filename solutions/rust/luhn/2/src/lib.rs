pub fn is_valid(code: &str) -> bool {
    fn double_up(n: u32) -> u32 { n * 2 }
    fn result_of_doubling_greater_than_nine(n: u32) -> bool { n > 4 }
    fn subtract_nine(n: u32) -> u32 { n - 9 }

    let mut count: usize = 0;
    code.chars()
        .rev()
        .filter(|c| !c.is_whitespace())
        .try_fold(0, |checksum, digit| {
            digit.to_digit(10).map(|mut number| {
                if !count.is_multiple_of(2) {
                    let should_subtract = result_of_doubling_greater_than_nine(number);
                    number = double_up(number);
                    if should_subtract {
                        number = subtract_nine(number);
                    }
                }
                count += 1;
                checksum + number
            })
        }).is_some_and(|checksum| count > 1 && checksum.is_multiple_of(10))
}
