pub fn collatz(n: u64) -> Option<u64> {
    if n == 0 { return None; }
    let divide_by_two = |n: u64| n / 2;
    let multiply_three_and_add_one = |n: u64| n * 3 + 1;
    let mut number = n;
    let mut steps = 0;

    loop {
        if number == 1 { break; }
        number = match number % 2 {
            0 => divide_by_two(number),
            _ => multiply_three_and_add_one(number),
        };
        steps += 1;
    }
    Some(steps)
}
