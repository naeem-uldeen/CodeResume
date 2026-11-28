#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    validate_bases(from_base, to_base)?;
    validate_digits(number, from_base)?;
    let base_10 = convert_to_base_10(number, from_base);

    Ok(convert_from_base_10(base_10, to_base))
}

fn validate_bases(from_base: u32, to_base: u32) -> Result<(), Error> {
    if from_base < 2 { return Err(Error::InvalidInputBase); }
    if to_base < 2 { return Err(Error::InvalidOutputBase); }

    Ok(())
}

fn validate_digits(number: &[u32], from_base: u32) -> Result<(), Error> {
    for &digit in number {
        if digit >= from_base { return Err(Error::InvalidDigit(digit)); }
    }

    Ok(())
}

fn convert_to_base_10(number: &[u32], from_base: u32) -> u64 {
    let mut value_so_far: u64 = 0;
    for &digit in number {
        value_so_far = value_so_far * (from_base as u64) + (digit as u64)
    }

    value_so_far
}

fn convert_from_base_10(mut number: u64, to_base: u32) -> Vec<u32> {
    if number == 0 { return vec![0]; }
    let base = to_base as u64;
    let mut digits = Vec::new();

    while number != 0 {
        digits.push((number % base) as u32);
        number /= base;
    }

    digits.reverse();
    digits
}
