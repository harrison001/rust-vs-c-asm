// 2️⃣ Immutable vs Mutable Variable Optimization
// 
// Compile: cargo rustc --bin immutable --release -- --emit=asm
// Assembly file: target/release/deps/immutable-*.s
//
// Key assembly differences to observe:
// - Immutable variable x may be optimized to immediate value or register
// - Mutable variable y may allocate stack space or use register
// - Release mode enables constant folding optimizations
// - Entire computation may be optimized to constant 43
// - Rust's ownership system enables aggressive optimizations
// - Immutability by default leads to better performance
// - No runtime overhead for immutability checks

fn main() {
    let x = 42;        // Immutable - compiler may optimize to immediate value
    let mut y = 0;     // Mutable - may allocate stack space
    y = x + 1;         // Computation may be constant folded
    println!("{}", y); // May directly print 43
} 