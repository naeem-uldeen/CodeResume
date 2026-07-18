pub fn is_armstrong_number(number: u32) -> bool {
    if number < 10 { return true }
    let digit_count = number.ilog10() + 1;

    number == std::iter::successors(
        Some(number), |&n|
            (n >= 10)
            .then(|| n / 10))
            .map(|n| (n % 10).pow(digit_count))
            .sum()
}
