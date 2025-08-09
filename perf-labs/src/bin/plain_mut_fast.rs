fn main() {
    let mut x = 0u64;
    for _ in 0..100_000_000 { x += 1; }
    println!("{}", x);
}
