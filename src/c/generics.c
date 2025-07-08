// 4️⃣ Generics and Monomorphization vs C Macros
// 
// Compile: gcc -O2 -S src/c/generics.c -o target/generics.s
// Assembly file: target/generics.s
//
// Key assembly differences to observe:
// - C macros are simple textual substitution
// - Assembly shows inlined multiplication operations
// - No function call overhead (due to macro expansion)
// - May optimize directly to immediate value calculations
// - No type safety checking, relies entirely on preprocessor
// - Potential for unexpected behavior with complex expressions
// - No compile-time type validation

#include <stdio.h>

#define SQUARE(x) ((x)*(x))

int main() {
    printf("%d\n", SQUARE(3));    // Preprocessor expands to ((3)*(3))
    printf("%f\n", SQUARE(2.0));  // Preprocessor expands to ((2.0)*(2.0))
    return 0;
} 