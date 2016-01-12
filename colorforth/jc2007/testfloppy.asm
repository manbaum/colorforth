;# program to load onto a USB key to see what a minimally passing "floppy"
;# is to my BIOS.
.intel_syntax noprefix ;# floppy boot segment
.code16
.org 0
.equ HEADS, 2
.equ SECTORS_PER_TRACK, 18
boot:
jmp	start
    nop
    .org 0x3 ;# just insurance
    .ascii "cmcf 1.0"
;# start DOS 2.0 BPB, offset 0xb
bps:
    .word 512       ;# bytes/sector
    .byte 1         ;# sector/cluster
    .word 1         ;# sector reserved
    .byte 0         ;# fats
    .word 0         ;# root directory entries
    .word 80 * HEADS * SECTORS_PER_TRACK ;# sectors
    .byte 0xf0      ;# media
    .word 0         ;# sectors/fat
/*
;# start of DOS 3.31 BPB, offset 0x18
spt:
    .word SECTORS_PER_TRACK ;# sectors/track
heads:
    .word HEADS     ;# heads
    .long 0         ;# hidden sectors
    .long 0         ;# total sectors
;# start of DOS 4.0 EBPB, offset 0x24
    .byte 0         ;# physical drive number
    .byte 0         ;# flags etc.
    .byte 0x29      ;# extended boot signature, 0x29=4.1
    .long 0x44fa7fe3 ;# volume serial number
;# the above serial number is probably freedos's timestamp:
;# $ printf '%d\n' 0x44fa7fe3
;# 1157267427
;# $ python
;# >>> datetime.datetime.fromtimestamp(1157267427)
;# datetime.datetime(2006, 9, 3, 0, 10, 27)
    .ascii "           " ;# volume label
    .ascii "FAT12   " ;# filesystem type
*/
start:
    mov ax, 0x0e00  ;# show character
    mov bx, 3       ;# bh=page 0; bl=color or attribute
    push ax
    push bx
    int 0x10        ;# BIOS function to show character in al
    pop bx
    pop ax
    inc al          ;# next character
    jmp start       ;# loop forever
    .org 0x1fe
    .byte 0x55, 0xaa ;# boot signature
;# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
