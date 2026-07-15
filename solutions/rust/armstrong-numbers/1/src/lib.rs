pub fn is_armstrong_number(number: u32) -> bool {
    fn digits(mut n: u32) -> Vec<u32> {
        if n == 0 {
            return vec![0];
        }
        let mut digits = Vec::new();
        while n > 0 {
            digits.push(n % 10);
            n /= 10;
        }
        digits.reverse();
        digits
    }

    let digits = digits(number);
    let count = digits.len() as u32;
    let sum: u32 = digits.iter().map(|&digit| digit.pow(count)).sum();
    sum == number
}
