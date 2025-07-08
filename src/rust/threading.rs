// 5️⃣ Multithreaded Synchronization and Memory Safety
// 
// Compile: cargo rustc --bin threading --release -- --emit=asm
// Assembly file: target/release/deps/threading-*.s
//
// Key assembly differences to observe:
// - Rust ensures Send/Sync traits at compile time
// - Arc atomic reference counting operations
// - Mutex lock and unlock function calls
// - Automatic Drop implementation for resource cleanup
// - May show atomic instructions (lock add, cmpxchg, etc.)
// - Thread safety verified at compile time, not runtime
// - Zero data races guaranteed by type system
// - Automatic memory management prevents use-after-free

use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];
    
    for _ in 0..10 {
        let c = Arc::clone(&counter);
        handles.push(thread::spawn(move || {
            let mut num = c.lock().unwrap();
            *num += 1;
        }));
    }
    
    for h in handles {
        h.join().unwrap();
    }
    
    println!("Result: {}", *counter.lock().unwrap());
} 