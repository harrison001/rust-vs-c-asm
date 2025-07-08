// 1️⃣ Ownership and Automatic Release vs C Manual Memory Management
// 
// Compile: cargo rustc --bin ownership --release -- --emit=asm
// Assembly file: target/release/deps/ownership-*.s
//
// Key assembly differences to observe:
// - Rust automatically inserts drop calls at function end
// - String::from triggers heap allocation function calls
// - Scope termination automatically calls drop_in_place for memory cleanup
// - Release mode may optimize away some intermediate steps
// - Memory safety guaranteed at compile time through ownership rules
// - No risk of use-after-free or double-free bugs
// - Zero-cost abstraction: ownership tracking happens at compile time

fn main() {
    let s = String::from("hello");
    println!("{}", s);
} // s automatically dropped here - assembly shows drop_in_place call 