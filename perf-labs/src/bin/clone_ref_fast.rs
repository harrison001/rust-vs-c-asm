use std::sync::Arc;
struct Big { buf: Arc<[u8]> }
fn main() {
    let b = Big { buf: Arc::<[u8]>::from(vec![1u8; 10*1024*1024]) };
    let mut v = Vec::with_capacity(200);
    for _ in 0..200 { v.push(Big { buf: b.buf.clone() }); }
    println!("{}", v.len());
}
