pub fn square_of_sum(n: u32) -> u32 {
    naturals(n).fold(0, |sum, number| sum + number).pow(2)
}

pub fn sum_of_squares(n: u32) -> u32 {
    naturals(n).fold(0, |sum, number| sum + number.pow(2))
}

pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n)
}

fn naturals(n: u32) -> impl Iterator<Item = u32> {
    (1..=n).rev()
}
