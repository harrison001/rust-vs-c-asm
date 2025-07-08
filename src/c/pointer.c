// 8️⃣ C Pointer Types and Manual Memory Management
// 
// Compile: gcc -O2 -S src/c/pointer.c -o target/pointer.s
// Assembly file: target/pointer.s
//
// Key assembly differences to observe:
// - No compile-time borrow checking, all pointer access is manual
// - const pointers are compiler hints, not enforced at runtime
// - Manual malloc/free required for heap allocation
// - Multiple pointers to same memory have no automatic reference counting
// - Volatile pointers prevent compiler optimizations
// - No automatic cleanup - programmer responsible for memory management
// - Risk of dangling pointers, use-after-free, and memory leaks

#include <stdio.h>
#include <stdlib.h>

// 1. Const pointer - similar to immutable reference but not enforced
int const_pointer_example() {
    int value = 42;
    const int *ptr = &value;  // const pointer, compiler hint only
    return *ptr;  // Direct memory access, no runtime checking
}

// 2. Mutable pointer - similar to mutable reference but no exclusivity
int mutable_pointer_example() {
    int value = 42;
    int *ptr = &value;  // Mutable pointer, no exclusivity guarantees
    *ptr += 10;         // Direct mutation, no borrow checking
    return *ptr;
}

// 3. Heap allocation - similar to Box<T> but manual cleanup required
int heap_pointer_example() {
    int *heap_ptr = malloc(sizeof(int));  // Manual heap allocation
    if (heap_ptr == NULL) return -1;      // Manual error checking required
    
    *heap_ptr = 42;
    int result = *heap_ptr + 10;
    
    free(heap_ptr);  // Manual deallocation required to prevent leaks
    return result;
}

// 4. Multiple pointers to same memory - simulates Rc<T> behavior
int shared_pointer_example() {
    int *original = malloc(sizeof(int));
    if (original == NULL) return -1;
    
    *original = 42;
    int *alias1 = original;  // Multiple pointers to same memory
    int *alias2 = original;  // No automatic reference counting
    
    int result = *alias1 + *alias2;  // Both access same memory location
    
    free(original);  // Only free once, programmer must track ownership
    // alias1 and alias2 are now dangling pointers (unsafe to use)
    return result;
}

// 5. Pointer arithmetic - array-style access
int pointer_arithmetic_example() {
    int array[3] = {10, 20, 30};
    int *ptr = array;  // Points to first element
    
    int result = 0;
    result += *ptr;        // array[0]
    result += *(ptr + 1);  // array[1] via pointer arithmetic
    result += *(ptr + 2);  // array[2] via pointer arithmetic
    
    return result;  // No bounds checking, potential buffer overflow
}

// 6. Volatile pointer - prevents compiler optimization, similar to raw pointers
int volatile_pointer_example() {
    int value = 42;
    volatile int *vol_ptr = &value;  // Volatile prevents optimization
    
    int mutable_value = 100;
    volatile int *mut_vol_ptr = &mutable_value;
    
    int read_val = *vol_ptr;      // Volatile read
    *mut_vol_ptr += 10;           // Volatile write
    
    return read_val + *mut_vol_ptr;
}

// 7. Function pointer - demonstrates pointer to code
int add_ten(int x) {
    return x + 10;
}

int function_pointer_example() {
    int (*func_ptr)(int) = add_ten;  // Pointer to function
    return func_ptr(42);  // Call through function pointer
}

int main() {
    // Call all functions to prevent compiler optimization
    printf("Const pointer: %d\n", const_pointer_example());
    printf("Mutable pointer: %d\n", mutable_pointer_example());
    printf("Heap pointer: %d\n", heap_pointer_example());
    printf("Shared pointer: %d\n", shared_pointer_example());
    printf("Pointer arithmetic: %d\n", pointer_arithmetic_example());
    printf("Volatile pointer: %d\n", volatile_pointer_example());
    printf("Function pointer: %d\n", function_pointer_example());
    
    return 0;
} 