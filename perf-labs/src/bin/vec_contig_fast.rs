fn main() {
    let n = 5_000_000;
    let mut v = Vec::with_capacity(n);
    for i in 0..n { v.push(i as i32); }
    let s: i64 = v.iter().map(|&x| x as i64).sum();
    println!("{}", s);
}
