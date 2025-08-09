#[derive(Clone)]
struct Big { buf: Vec<u8> }
fn main() {
    let b = Big { buf: vec![1u8; 10*1024*1024] }; // 10 MB
    let mut v = Vec::with_capacity(200);
    for _ in 0..200 { v.push(b.clone()); } // ~2 GB total copied
    println!("{}", v.len());
}
