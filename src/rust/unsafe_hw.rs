// 6️⃣ Unsafe Hardware Register Access
// 
// Compile: cargo rustc --bin unsafe_hw --release -- --emit=asm
// Assembly file: target/release/deps/unsafe_hw-*.s
//
// Key assembly differences to observe:
// - Direct memory access instructions (mov)
// - Volatile operations prevent compiler optimizations
// - unsafe block isolates dangerous operations
// - Generated assembly nearly identical to C version
// - Rust type system ensures only unsafe blocks can use raw pointers
// - Safety boundaries clearly marked in source code
// - Compiler cannot optimize away volatile operations
// - Zero-cost abstraction: unsafe has no runtime overhead

fn main() {
    let ptr = 0x1000 as *mut u32;
    unsafe {
        // Volatile write prevents compiler optimization
        core::ptr::write_volatile(ptr, 42);
        // Volatile read prevents compiler optimization
        let val = core::ptr::read_volatile(ptr);
        println!("{}", val);
    }
} 