;# program to load onto a USB key to see what a minimally passing "floppy"
;# is to my BIOS.
.intel_syntax noprefix ;# floppy boot segment
.code16
.org 0
boot:
	jmp	start
	nop
	.org 0x3 ;# just insurance
	.asciz "cmcf 1.0"
start:
	nop
