fn main() {
    let mut v = Vec::new();
    for i in 0..5_000_000 { v.push(i); }
    println!("{}", v.len());
}
