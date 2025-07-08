// 7️⃣ Tail Recursion Optimization and Function Inlining
// 
// Compile: cargo rustc --bin recursion --release -- --emit=asm
// Assembly file: target/release/deps/recursion-*.s
//
// Key assembly differences to observe:
// - This is NOT true tail recursion (multiplication happens after recursive call)
// - Compiler may inline small recursive calls
// - Release mode may optimize to iterative loop
// - May show stack frame creation and destruction
// - For factorial(5) may be computed as constant 120
// - LLVM backend provides aggressive optimizations
// - Stack overflow protection through stack guards
// - Function call overhead vs optimization trade-offs

fn factorial(n: u64) -> u64 {
    if n == 0 {
        1
    } else {
        n * factorial(n - 1)  // NOT tail recursive - multiplication after recursive call
    }
}

fn main() {
    println!("{}", factorial(5));
} 