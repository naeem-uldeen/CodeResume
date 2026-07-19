use std::cmp::Ordering;

pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let mut lo = 0;
    let mut hi = array.len();

    while lo < hi {
        let mid = lo + (hi - lo) / 2;
        match array[mid].cmp(&key) {
            Ordering::Equal => return Some(mid),
            Ordering::Less => lo = mid + 1,
            Ordering::Greater => hi = mid, 
        }
    }
    None
}
