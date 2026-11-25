pub fn is_prime(n: u64) -> bool {
    if n == 2 { return true; }
    if n <= 1 || n.is_multiple_of(2) { return false; }

    let limit = n.isqrt();
    for i in (3..=limit).step_by(2) {
        if n % i == 0 {
            return false;
        }
    }
    true
}

pub fn nth(n: u32) -> u32 {
    (2u64..)
        .filter(|&candidate| is_prime(candidate))
        .nth(n as usize)
        .expect("the range 2.. is unbounded, so a prime always exists") as u32
}
