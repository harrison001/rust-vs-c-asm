// 1️⃣ Ownership and Automatic Release vs C Manual Memory Management
// 
// Compile: gcc -O2 -S src/c/ownership.c -o target/ownership.s
// Assembly file: target/ownership.s
//
// Key assembly differences to observe:
// - Explicit malloc call for memory allocation
// - Explicit free call for memory deallocation
// - Forgetting free() causes memory leaks
// - sprintf has potential buffer overflow risks (safe in this example)
// - No compile-time memory safety guarantees
// - Risk of use-after-free if accessing s after free()
// - Risk of double-free if free() called twice
// - Manual memory management overhead and error-prone nature

#include <stdio.h>
#include <stdlib.h>

int main() {
    char *s = malloc(6);
    sprintf(s, "hello");
    printf("%s\n", s);
    free(s);  // Manual deallocation required - assembly shows free call
    return 0;
} 