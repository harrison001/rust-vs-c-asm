# Rust vs C Assembly Comparison Makefile

# Create target directory
TARGET_DIR = target

# Rust binary names
RUST_BINS = ownership immutable bounds_check generics threading unsafe_hw recursion pointer

# C source files
C_SOURCES = $(wildcard src/c/*.c)
C_NAMES = $(basename $(notdir $(C_SOURCES)))

# Default target
all: rust_asm c_asm

# Create target directory
$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

# Build all Rust examples and generate assembly
rust_asm: $(TARGET_DIR)
	@echo "Building Rust examples and generating assembly..."
	$(foreach bin,$(RUST_BINS), \
		cargo rustc --bin $(bin) --release -- --emit=asm && \
		echo "Generated assembly for $(bin)" ;)

# Build all C examples and generate assembly
c_asm: $(TARGET_DIR)
	@echo "Building C examples and generating assembly..."
	$(foreach src,$(C_SOURCES), \
		gcc -O2 -S $(src) -o $(TARGET_DIR)/$(basename $(notdir $(src))).s && \
		echo "Generated assembly for $(basename $(notdir $(src)))" ;)

# Build C threading example with pthread
c_threading: $(TARGET_DIR)
	gcc -O2 -S src/c/threading.c -o $(TARGET_DIR)/threading.s -lpthread

# Clean build artifacts
clean:
	cargo clean
	rm -rf $(TARGET_DIR)

# Run all Rust examples
run_rust:
	@echo "Running Rust examples..."
	$(foreach bin,$(RUST_BINS), \
		echo "Running $(bin):" && \
		cargo run --bin $(bin) --release && \
		echo "" ;)

# Run all C examples (compile and run)
run_c:
	@echo "Running C examples..."
	$(foreach src,$(C_SOURCES), \
		echo "Running $(basename $(notdir $(src))):" && \
		gcc -O2 $(src) -o $(TARGET_DIR)/$(basename $(notdir $(src))) $(if $(findstring threading,$(src)),-lpthread) && \
		./$(TARGET_DIR)/$(basename $(notdir $(src))) && \
		echo "" ;)

# Compare assembly files
compare: rust_asm c_asm
	@echo "Assembly files generated:"
	@echo "Rust assembly files are in: target/release/deps/"
	@echo "C assembly files are in: target/"
	@echo ""
	@echo "🔍 Running detailed comparison..."
	./compare_asm.sh

# Show assembly for a specific example
show_asm_%:
	@echo "=== Rust Assembly for $* ==="
	@find target/release/deps -name "$**" -type f -exec cat {} \; || echo "Rust assembly not found"
	@echo ""
	@echo "=== C Assembly for $* ==="
	@cat target/$*.s 2>/dev/null || echo "C assembly not found"

# Show side-by-side diff for a specific example
diff_%:
	@echo "=== Side-by-side diff for $* ==="
	@rust_file=$$(find target/release/deps -name "$*-*.s" -type f | head -1) && \
	c_file="target/$*.s" && \
	if [[ -f "$$rust_file" && -f "$$c_file" ]]; then \
		echo "Comparing $$rust_file and $$c_file"; \
		diff -u "$$c_file" "$$rust_file" | head -50; \
	else \
		echo "Files not found"; \
	fi

# Show key differences for a specific example
analyze_%:
	@echo "=== Analysis for $* ==="
	@rust_file=$$(find target/release/deps -name "$*-*.s" -type f | head -1) && \
	c_file="target/$*.s" && \
	if [[ -f "$$rust_file" && -f "$$c_file" ]]; then \
		echo "File sizes:"; \
		echo "  C:    $$(wc -l < "$$c_file") lines"; \
		echo "  Rust: $$(wc -l < "$$rust_file") lines"; \
		echo ""; \
		echo "Key function calls:"; \
		echo "C:"; \
		grep -n "bl\|call" "$$c_file" | head -10; \
		echo ""; \
		echo "Rust:"; \
		grep -n "bl\|call" "$$rust_file" | head -10; \
	else \
		echo "Files not found"; \
	fi

# Help
help:
	@echo "Available targets:"
	@echo "  all             - Build all examples and generate assembly"
	@echo "  rust_asm        - Build Rust examples and generate assembly"
	@echo "  c_asm           - Build C examples and generate assembly"
	@echo "  run_rust        - Run all Rust examples"
	@echo "  run_c           - Run all C examples"
	@echo "  compare         - Generate assembly files and run detailed comparison"
	@echo "  clean           - Clean build artifacts"
	@echo "  help            - Show this help message"
	@echo ""
	@echo "Analysis targets:"
	@echo "  show_asm_<n> - Show assembly for specific example"
	@echo "  diff_<n>     - Show side-by-side diff for specific example"
	@echo "  analyze_<n>  - Show key differences for specific example"
	@echo ""
	@echo "Examples:"
	@echo "  make compare           - Full comparison of all examples"
	@echo "  make diff_ownership    - Diff ownership example"
	@echo "  make analyze_generics  - Analyze generics example"
	@echo "  make analyze_pointer   - Analyze pointer types example"

.PHONY: all rust_asm c_asm clean run_rust run_c compare help 