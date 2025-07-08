// 7️⃣ Tail Recursion Optimization and Function Inlining
// 
// Compile: gcc -O2 -S src/c/recursion.c -o target/recursion.s
// Assembly file: target/recursion.s
//
// Key assembly differences to observe:
// - This is NOT true tail recursion (multiplication happens after recursive call)
// - Compiler may inline small recursive calls
// - -O2 optimization may convert to iterative loop
// - May show stack frame creation and destruction
// - For factorial(5) may be computed as constant 120
// - GCC provides similar optimizations to Rust/LLVM
// - No stack overflow protection by default
// - Function call overhead vs optimization trade-offs

#include <stdio.h>

unsigned long long factorial(unsigned long long n) {
    if (n == 0) return 1;
    else return n * factorial(n - 1);  // NOT tail recursive - multiplication after call
}

int main() {
    printf("%llu\n", factorial(5));
    return 0;
} 