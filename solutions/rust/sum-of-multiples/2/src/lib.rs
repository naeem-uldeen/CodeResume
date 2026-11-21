use std::collections::HashSet;

pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let unique_factors: HashSet<u32> = factors.iter().copied().filter(|&f| f != 0).collect();
    let independent_factors: Vec<u32> = unique_factors
        .iter()
        .copied()
        .filter(|&f| !unique_factors.iter().any(|&g| g != f && f % g == 0))
        .collect();
    let n = independent_factors.len();
    let mut total_sum = 0u64;
    let limit_u64 = limit as u64;

    for mask in 1..(1u64 << n) {
        let mut lcm = 1u64;
        let mut bits = 0;

        for (i, &factor) in independent_factors.iter().enumerate() {
            if (mask >> i) & 1 == 1 {
                bits += 1;
                let factor_u64 = factor as u64;
                let gcd = gcd(lcm, factor_u64);
                lcm = lcm / gcd * factor_u64;
                if lcm >= limit_u64 {
                    break;
                }
            }
        }

        if lcm >= limit_u64 {
            continue;
        }

        let count = (limit_u64 - 1) / lcm;
        let subset_sum = lcm * count * (count + 1) / 2;

        if bits % 2 == 1 {
            total_sum += subset_sum;
        } else {
            total_sum -= subset_sum;
        }
    }

    total_sum as u32
}

fn gcd(mut a: u64, mut b: u64) -> u64 {
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a
}
