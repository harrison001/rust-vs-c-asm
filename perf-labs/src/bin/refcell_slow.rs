use std::cell::RefCell;
fn main() {
    let x = RefCell::new(0u64);
    for _ in 0..100_000_000 { *x.borrow_mut() += 1; }
    println!("{}", x.borrow());
}
