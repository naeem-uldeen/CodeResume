pub fn is_armstrong_number(number: u32) -> bool {
    let digit_count = number
        .checked_ilog10()
        .map_or(1, |exp| exp + 1);

    let narcissistic_sum: u32 = std::iter::successors(
        Some(number), |&n|
            (n >= 10)
            .then_some(n / 10))
            .map(|n| (n % 10).pow(digit_count))
            .sum();

    narcissistic_sum == number
}
