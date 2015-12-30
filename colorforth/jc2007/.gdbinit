target remote 127.0.0.1:1234
break *pm+loadaddr
break *0x7c00
printf "To advance one machine instruction, type 'si'\n"
printf "To set a register, e.g: set $eax = 0x55\n"
printf "Warning: during relocation, instructions may not show correctly\n"
printf "In that case, `x/5i *0x90184` or whatever the address may be\n"
printf "Make sure to `set architecture i386` after protected mode entered\n"
set architecture i8086
display/5i $pc
continue
