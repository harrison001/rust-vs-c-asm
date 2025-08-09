use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    let counter = Arc::new(Mutex::new(0u64));
    let mut hs = vec![];
    for _ in 0..4 {
        let c = Arc::clone(&counter);
        hs.push(thread::spawn(move || {
            for _ in 0..2_000_000 {
                *c.lock().unwrap() += 1;
            }
        }));
    }
    for h in hs { h.join().unwrap(); }
    println!("{}", *counter.lock().unwrap());
}
