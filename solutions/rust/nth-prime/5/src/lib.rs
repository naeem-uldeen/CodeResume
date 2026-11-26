const MSG: &str = "the range 2.. is unbounded, so a prime always exists";

pub fn is_prime(primes: &mut Vec<u64>, n: u64) -> bool {
    let limit = n.isqrt();
    if primes
        .iter()
        .take_while(|&&p| p <= limit)
        .any(|&p| n.is_multiple_of(p))
    {
        return false;
    }
    primes.push(n);
    true
}

pub fn nth(n: u32) -> u32 {
    let mut primes = Vec::new();
    (2u64..)
        .filter(|&candidate| is_prime(&mut primes, candidate))
        .nth(n as usize)
        .expect(MSG) as u32
}
