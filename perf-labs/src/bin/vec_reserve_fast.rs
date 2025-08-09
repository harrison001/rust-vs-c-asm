fn main() {
    let n = 5_000_000;
    let mut v = Vec::with_capacity(n); // or v.reserve_exact(n);
    for i in 0..n { v.push(i); }
    println!("{}", v.len());
}
