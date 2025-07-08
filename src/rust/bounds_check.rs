// 3️⃣ Bounds Checking and Memory Safety
// 
// Compile: cargo rustc --bin bounds_check --release -- --emit=asm
// Assembly file: target/release/deps/bounds_check-*.s
//
// Key assembly differences to observe:
// - Rust inserts bounds checking code before array access
// - Out-of-bounds access triggers panic handler function call
// - Assembly shows comparison instructions checking if index exceeds bounds
// - Contains conditional jump instructions for panic branches
// - Release mode may optimize some bounds checks but not this example
// - Guaranteed memory safety at runtime with zero-cost when bounds are known
// - Prevents buffer overflow attacks and undefined behavior

use std::env;

fn main() {
    let arr = [1, 2, 3];
    // Use dynamic index to prevent compile-time checking
    let index = env::args().len() + 4; // This produces 5
    // This triggers panic - assembly shows bounds check and panic call
    println!("{}", arr[index]); // Index out of bounds, triggers panic
} 