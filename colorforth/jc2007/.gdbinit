target remote 127.0.0.1:1234
break *pm+loadaddr
 commands
 silent
 set architecture i386
 continue
 end
break *0x7c00
printf "To advance one machine instruction, type 'si'\n"
printf "To set a register, e.g: set $eax = 0x55\n"
set architecture i8086
display/5i $pc
continue
