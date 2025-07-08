// 2️⃣ Immutable vs Mutable Variable Optimization
// 
// Compile: gcc -O2 -S src/c/immutable.c -o target/immutable.s
// Assembly file: target/immutable.s
//
// Key assembly differences to observe:
// - const variable x may be optimized to immediate value
// - Regular variable y may allocate stack space or use register
// - -O2 optimization enables constant folding
// - Entire computation may be optimized to constant 43
// - const is hint to compiler, not enforced at runtime
// - Mutable by default may prevent some optimizations
// - const doesn't provide same guarantees as Rust's immutability

#include <stdio.h>

int main() {
    const int x = 42;  // const variable - compiler may optimize to immediate
    int y = 0;         // Regular variable - may allocate stack or use register
    y = x + 1;         // Computation may be constant folded
    printf("%d\n", y); // May directly print 43
    return 0;
} 