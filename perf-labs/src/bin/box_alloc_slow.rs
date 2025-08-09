fn main() {
    let mut v = Vec::new();
    for i in 0..5_000_000 {
        v.push(Box::new(i as i32));
    }
    let s: i64 = v.iter().map(|x| **x as i64).sum();
    println!("{}", s);
}
