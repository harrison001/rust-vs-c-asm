// 4️⃣ Generics and Monomorphization vs C Macros
// 
// Compile: cargo rustc --bin generics --release -- --emit=asm
// Assembly file: target/release/deps/generics-*.s
//
// Key assembly differences to observe:
// - Rust generates specialized function versions for each type (monomorphization)
// - Assembly shows multiple square function versions: one for i32, one for f64
// - Function names include type information mangling
// - Each version is optimized for its specific type
// - No runtime type checking overhead
// - Zero-cost abstraction with compile-time specialization
// - Type safety guaranteed at compile time

fn square<T: std::ops::Mul<Output = T> + Copy>(x: T) -> T {
    x * x
}

fn main() {
    println!("{}", square(3));    // Generates square::<i32> version
    println!("{}", square(2.0));  // Generates square::<f64> version
} 