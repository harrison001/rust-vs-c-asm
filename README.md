# 🦀 Rust vs C: Assembly Deep Dive

A hands-on comparison between Rust and C at the assembly level.
Explore how zero-cost abstractions, ownership models, and type systems affect real machine code.

> 📸 **Want the full story with live GDB debugging sessions, assembly screenshots, and real-world commentary?**
> 👉 [Read the complete article here](https://harrisonsec.com/blog/rust-vs-c-assembly-performance-safety/)  
> *(Includes all the annotated GDB screenshots, performance commentary, and the story behind the code.)*
---

> 📌 Compare Rust and C in terms of memory safety, pointer behavior, runtime checks, and compiler optimizations — **all at the assembly level**.

---

## 🎯 Project Goal

This project demonstrates fundamental differences between Rust and C by analyzing their generated assembly code across critical areas:

- **Memory Management**: Ownership vs Manual Control
- **Safety Guarantees**: Compile-time vs Runtime Checks
- **Abstraction Cost**: Zero-cost vs Manual Overhead
- **Concurrency Models**: Type-safe vs Raw Synchronization
- **Pointer Semantics**: Rich Types vs Raw Pointers

---

## 📁 Project Structure

```
src/
├── rust/
│   ├── ownership.rs      # Automatic memory management
│   ├── immutable.rs      # Immutability and optimization
│   ├── bounds_check.rs   # Array bounds safety
│   ├── generics.rs       # Type-safe generics
│   ├── threading.rs      # Thread-safe concurrency
│   ├── unsafe_hw.rs      # Hardware register access
│   ├── recursion.rs      # Function call optimization
│   └── pointer.rs        # Comprehensive pointer types
└── c/
    ├── ownership.c       # Manual memory management
    ├── immutable.c       # const hints and optimization
    ├── bounds_check.c    # Unchecked array access
    ├── generics.c        # Macro-based generics
    ├── threading.c       # pthread synchronization
    ├── unsafe_hw.c       # Direct hardware access
    ├── recursion.c       # Function call patterns
    └── pointer.c         # Traditional pointer usage
```

---

## 🔍 Assembly-Level Comparisons

### 1️⃣ Ownership and Memory Management
- **Rust**: Automatic `drop_in_place`, no use-after-free
- **C**: Manual `malloc`/`free`, prone to leaks and UAF

### 2️⃣ Immutability and Optimization
- **Rust**: Immutable by default → better inlining & optimization
- **C**: `const` as hint only, mutable by default

### 3️⃣ Bounds Checking
- **Rust**: Conditional jumps to panic handlers
- **C**: No checks, buffer overflows = undefined behavior

### 4️⃣ Generics vs Macros
- **Rust**: Monomorphization, type-safe
- **C**: Preprocessor macros, type-unsafe

### 5️⃣ Thread Safety
- **Rust**: `Send`/`Sync` traits at compile-time
- **C**: Manual `pthread_mutex`, error-prone

### 6️⃣ Hardware Access
- **Rust**: Isolated via `unsafe` blocks
- **C**: All access treated equally, no guardrails

### 7️⃣ Recursion
- **Rust**: Same optimizations as C + stack checks
- **C**: Compiler-dependent optimizations, no overflow checks

### 8️⃣ Pointer Types (NEW)
- **Rust**: Fine-grained references, ownership enforced
- **C**: One-size-fits-all pointer, no lifetime tracking

---

## 🛠️ Building and Analysis

### Quick Start

```bash
make all            # Build all examples and generate assembly
make compare        # Compare Rust and C outputs
make analyze_ptr    # Analyze specific pointer comparison
```

### Individual Commands

```bash
make rust_asm       # Rust-only builds
make c_asm          # C-only builds
make run_rust       # Run all Rust examples
make run_c          # Run all C examples
make diff_bounds    # Compare bounds checking
```

---

## 📂 Assembly Output

- **Rust**: `target/release/deps/example-*.s`
- **C**: `target/example.s`

You can inspect these outputs in your disassembler or `objdump -d`.

---

## 🔬 Key Observations

| Aspect             | Rust                                   | C                                |
|--------------------|----------------------------------------|----------------------------------|
| **Memory Safety**   | Automatic `drop_in_place`              | Manual `malloc` / `free`         |
| **Bounds Checking** | Jump to panic handlers on violation    | No checks, UB                   |
| **Pointer Semantics**| Rich pointer types & lifetimes        | Raw pointers only               |
| **Thread Safety**   | Compile-time checked with traits       | Manual, prone to races          |
| **Optimization**    | Zero-cost abstraction via LLVM         | Manual hints, limited inlining  |

---

## 🧪 Pointer Type Comparison

### Rust
```rust
&T              // Immutable reference
&mut T          // Exclusive mutable reference
Box<T>          // Heap allocation
Rc<T>           // Single-threaded ref counting
Arc<T>          // Thread-safe atomic ref counting
*const T, *mut T // Raw pointers (unsafe)
Pin<Box<T>>     // Prevents movement (pinned heap)
```

### C
```c
const int *ptr  // const pointer
int *ptr        // mutable pointer
malloc/free     // manual heap allocation
volatile int *  // volatile access
int *alias      // no ownership model
```

---

## 📊 Performance Insights

1. **Zero-Cost Abstractions**: Rust’s safety features often compile to identical assembly as hand-optimized C
2. **Aggressive Optimization**: Rust’s ownership and mutability rules allow more predictable optimizations
3. **Minimal Runtime Cost**: Bounds checks and drops are lightweight
4. **Better Safety by Design**: Common C pitfalls (use-after-free, race conditions) are structurally impossible in Rust

---

## 🧠 Use Cases

Perfect for:
- 🔍 Security Researchers
- ⚙️ Systems Engineers
- 🧵 Compiler Developers
- 🧠 Advanced Learners of Low-Level Programming

---

## 🚀 Get Started

```bash
# Prerequisites
rustup install stable
sudo dnf install gcc make -y

# Build and analyze
make all
```
*Rust delivers memory and thread safety without sacrificing performance. This project proves it — one assembly line at a time.*
---
## 📸 **Full GDB Sessions, Annotated Assembly, and More**

The code in this repo is explained **step-by-step** in my in-depth article:  
👉 [Rust vs C Assembly: Panic or Segfault? (with GDB analysis)](https://harrisonsec.com/blog/rust-vs-c-assembly-performance-safety/)

- Complete walkthroughs for every function
- Assembly screenshots from GDB sessions
- Real-world systems programming insights

---

*For questions or in-depth discussion, feel free to comment on the blog, or reach out via [LinkedIn](https://www.linkedin.com/in/harrison001/).*
