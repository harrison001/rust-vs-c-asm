set pagination off
set disassemble-next-line on
set confirm off
set print asm-demangle on
set disassembly-flavor intel
break main
run
layout asm
# After hitting main:
disassemble /m main
info registers
# step a bit:
stepi
x/16i $rip
