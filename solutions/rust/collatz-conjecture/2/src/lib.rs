pub fn collatz(n: u64) -> Option<u64> {
    match n {
        0 => None,
        1 => Some(0),
        _ => collatz(if n.is_multiple_of(2) {
            n / 2
        } else {
            3 * n + 1
        }).map(|steps| steps + 1),
    }
}
