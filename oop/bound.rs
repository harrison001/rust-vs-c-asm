use std::fmt::Display;

fn print_all<T: Display>(items: &[T]) {
    for it in items { println!("{it}"); }
}

fn main() {
    print_all(&[1, 2, 3]);           // i32 实现了 Display
    print_all(&["a", "b", "c"]);     // &str 实现了 Display
}
