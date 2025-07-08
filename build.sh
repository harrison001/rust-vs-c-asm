#!/bin/bash

# Rust vs C Assembly Comparison Build Script

echo "🚀 Building Rust vs C Assembly Comparison Project"
echo "================================================="

# Check if required tools are installed
echo "Checking required tools..."

if ! command -v rustc &> /dev/null; then
    echo "❌ Rust compiler not found. Please install Rust: https://rustup.rs/"
    exit 1
fi

if ! command -v gcc &> /dev/null; then
    echo "❌ GCC compiler not found. Please install GCC"
    exit 1
fi

if ! command -v make &> /dev/null; then
    echo "❌ Make tool not found. Please install Make"
    exit 1
fi

echo "✅ All required tools found"
echo ""

# Create target directory
mkdir -p target

# Build and test
echo "Building all examples..."
make all

echo ""
echo "🎉 Build completed successfully!"
echo ""
echo "Next steps:"
echo "1. Run 'make run_rust' to execute all Rust examples"
echo "2. Run 'make run_c' to execute all C examples"
echo "3. Run 'make compare' to generate assembly comparison files"
echo "4. Check the README.md for detailed usage instructions"
echo ""
echo "Assembly files will be in:"
echo "- Rust: target/release/deps/"
echo "- C: target/" 