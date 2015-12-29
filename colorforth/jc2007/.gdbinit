target remote 127.0.0.1:1234
break *0x7c00
printf "To advance one machine instruction, type 'si'\n"
printf "To set a register, e.g: set $eax = 0x55\n"
display/5i $pc
continue
