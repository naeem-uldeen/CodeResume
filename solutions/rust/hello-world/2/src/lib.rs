pub fn hello() -> &'static str {
    let mut original = "Goodbye, Mars!".to_owned();

    original.replace_range(9..13, "World");
    original.replace_range(0..7, "Hello");

    Box::leak(original.into_boxed_str())
}
