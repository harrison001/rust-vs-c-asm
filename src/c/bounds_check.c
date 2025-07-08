// 3️⃣ Bounds Checking and Memory Safety
// 
// Compile: gcc -O2 -S src/c/bounds_check.c -o target/bounds_check.s
// Assembly file: target/bounds_check.s
//
// Key assembly differences to observe:
// - C has no bounds checking, performs direct memory access
// - Assembly shows only simple memory address calculation
// - No safety check branches or validation code
// - May access undefined memory regions
// - Undefined behavior - may crash or return garbage values
// - Vulnerable to buffer overflow attacks
// - No runtime safety guarantees

#include <stdio.h>

int main() {
    int arr[3] = {1, 2, 3};
    // No bounds checking - direct access to out-of-bounds memory
    printf("%d\n", arr[5]); // Undefined behavior - may crash or return garbage
    return 0;
} 