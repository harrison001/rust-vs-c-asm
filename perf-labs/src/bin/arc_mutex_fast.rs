use std::thread;

fn main() {
    let mut hs = vec![];
    for _ in 0..4 {
        hs.push(thread::spawn(move || {
            let mut local = 0u64;
            for _ in 0..2_000_000 { local += 1; }
            local
        }));
    }
    let sum: u64 = hs.into_iter().map(|h| h.join().unwrap()).sum();
    println!("{}", sum);
}
