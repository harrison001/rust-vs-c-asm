// 6️⃣ Unsafe Hardware Register Access
// 
// Compile: gcc -O2 -S src/c/unsafe_hw.c -o target/unsafe_hw.s
// Assembly file: target/unsafe_hw.s
//
// Key assembly differences to observe:
// - Direct memory access instructions (mov)
// - volatile keyword prevents compiler optimizations
// - No safety boundaries, entire program can use raw pointers
// - Generated assembly nearly identical to Rust version
// - C has no type system level safety guarantees
// - No distinction between safe and unsafe operations
// - Compiler cannot optimize away volatile operations
// - Potential for accidental unsafe operations anywhere in code

#include <stdio.h>

int main() {
    volatile unsigned int *ptr = (unsigned int *)0x1000;
    *ptr = 42;          // Volatile write prevents compiler optimization
    unsigned int val = *ptr;  // Volatile read prevents compiler optimization
    printf("%u\n", val);
    return 0;
} 