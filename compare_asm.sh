#!/bin/bash

# Rust vs C Assembly Comparison Script

echo "🔍 Rust vs C Assembly Comparison"
echo "================================"

# Function to show key differences
show_comparison() {
    local example=$1
    echo ""
    echo "📋 $example Example:"
    echo "-------------------"
    
    # Find the Rust assembly file
    rust_file=$(find target/release/deps -name "${example}-*.s" -type f | head -1)
    c_file="target/${example}.s"
    
    if [[ -f "$rust_file" && -f "$c_file" ]]; then
        echo "✅ Found both files:"
        echo "  Rust: $rust_file"
        echo "  C:    $c_file"
        echo ""
        
        # Show key function calls for each example
        case $example in
            "ownership")
                echo "🔍 Memory Management Calls:"
                echo "C (malloc/free):"
                grep -n "malloc\|free" "$c_file" | head -5
                echo ""
                echo "Rust (drop):"
                grep -n "drop\|alloc" "$rust_file" | head -5
                ;;
            "bounds_check")
                echo "🔍 Bounds Check Calls:"
                echo "C (direct access):"
                grep -n "array\|bound" "$c_file" | head -5
                echo ""
                echo "Rust (panic):"
                grep -n "panic\|bound" "$rust_file" | head -5
                ;;
            "generics")
                echo "🔍 Generic/Template Calls:"
                echo "C (macro expansion):"
                grep -n "SQUARE\|mul" "$c_file" | head -5
                echo ""
                echo "Rust (monomorphization):"
                grep -n "square\|mul" "$rust_file" | head -5
                ;;
            "threading")
                echo "🔍 Threading Calls:"
                echo "C (pthread):"
                grep -n "pthread\|mutex" "$c_file" | head -5
                echo ""
                echo "Rust (Arc/Mutex):"
                grep -n "arc\|mutex\|atomic" "$rust_file" | head -5
                ;;
        esac
        
        echo ""
        echo "📊 File Sizes:"
        echo "  C:    $(wc -l < "$c_file") lines"
        echo "  Rust: $(wc -l < "$rust_file") lines"
        
    else
        echo "❌ Missing files:"
        [[ ! -f "$rust_file" ]] && echo "  Rust file not found"
        [[ ! -f "$c_file" ]] && echo "  C file not found"
    fi
}

# Compare all examples
examples=("ownership" "bounds_check" "generics" "threading" "immutable" "recursion" "unsafe_hw")

for example in "${examples[@]}"; do
    show_comparison "$example"
done

echo ""
echo "🎯 Quick Commands:"
echo "=================="
echo "View C assembly:    cat target/ownership.s"
echo "View Rust assembly: cat target/release/deps/ownership-*.s"
echo "Side-by-side diff:  diff -u target/ownership.s target/release/deps/ownership-*.s"
echo ""
echo "💡 Key Differences to Look For:"
echo "- C: malloc/free calls"
echo "- Rust: drop_in_place calls"
echo "- C: direct memory access"
echo "- Rust: bounds checking branches"
echo "- C: simple function calls"
echo "- Rust: monomorphized function names" 