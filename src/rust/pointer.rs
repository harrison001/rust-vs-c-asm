// 8️⃣ Rust Pointer Types and Memory Management
// 
// Compile: cargo rustc --bin pointer --release -- --emit=asm
// Assembly file: target/release/deps/pointer-*.s
//
// Key assembly differences to observe:
// - Immutable/mutable references have zero runtime cost
// - Box<T> generates heap allocation and automatic deallocation
// - Rc<T> includes reference counting with atomic operations
// - Arc<T> uses atomic reference counting for thread safety
// - Raw pointers require unsafe blocks and generate direct memory access
// - Pin<Box<T>> prevents movement but has same allocation cost as Box<T>
// - Rust's ownership system prevents use-after-free at compile time

use std::rc::Rc;
use std::sync::Arc;
use std::pin::Pin;

// 1. Immutable reference - zero cost abstraction
fn immutable_reference_example() -> i32 {
    let value = 42;
    let reference: &i32 = &value;  // Immutable borrow, compile-time checked
    *reference  // Dereference has no runtime cost
}

// 2. Mutable reference - exclusive access guaranteed
fn mutable_reference_example() -> i32 {
    let mut value = 42;
    let reference: &mut i32 = &mut value;  // Exclusive mutable borrow
    *reference += 10;  // Safe mutation through reference
    *reference
}

// 3. Box<T> - heap allocation with automatic cleanup
fn box_pointer_example() -> i32 {
    let boxed_value: Box<i32> = Box::new(42);  // Heap allocation
    let result = *boxed_value + 10;
    result  // Box automatically deallocated when dropped
}

// 4. Rc<T> - reference counted smart pointer (single-threaded)
fn rc_pointer_example() -> i32 {
    let rc_value: Rc<i32> = Rc::new(42);  // Reference count = 1
    let rc_clone = Rc::clone(&rc_value);   // Reference count = 2
    let result = *rc_value + *rc_clone;    // Both point to same data
    result  // Reference count decremented automatically
}

// 5. Arc<T> - atomic reference counted smart pointer (thread-safe)
fn arc_pointer_example() -> i32 {
    let arc_value: Arc<i32> = Arc::new(42);  // Atomic reference count = 1
    let arc_clone = Arc::clone(&arc_value);  // Atomic increment to 2
    let result = *arc_value + *arc_clone;    // Thread-safe shared ownership
    result  // Atomic decrement when dropped
}

// 6. Raw pointers - unsafe but direct memory access
fn raw_pointer_example() -> i32 {
    let value = 42;
    let const_ptr: *const i32 = &value;  // Raw const pointer
    let mut mutable_value = 100;
    let mut_ptr: *mut i32 = &mut mutable_value;  // Raw mutable pointer
    
    unsafe {
        // Direct memory access without safety checks
        let read_const = *const_ptr;      // Read through const pointer
        *mut_ptr += 10;                   // Write through mutable pointer
        read_const + *mut_ptr
    }
}

// 7. Pin<Box<T>> - prevents movement, useful for self-referential structs
fn pinned_pointer_example() -> i32 {
    let boxed_value = Box::new(42);
    let pinned: Pin<Box<i32>> = Pin::new(boxed_value);  // Cannot be moved
    *pinned  // Dereference: Pin<Box<T>> auto-derefs to T
}

fn main() {
    // Call all functions to prevent compiler optimization
    println!("Immutable reference: {}", immutable_reference_example());
    println!("Mutable reference: {}", mutable_reference_example());
    println!("Box pointer: {}", box_pointer_example());
    println!("Rc pointer: {}", rc_pointer_example());
    println!("Arc pointer: {}", arc_pointer_example());
    println!("Raw pointer: {}", raw_pointer_example());
    println!("Pinned pointer: {}", pinned_pointer_example());
} 