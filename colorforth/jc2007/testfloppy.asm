;# program to load onto a USB key to see what a minimally passing "floppy"
;# is to my BIOS.
.intel_syntax noprefix ;# floppy boot segment
.code16
.org 0
.equ HEADS, 2
.equ SECTORS_PER_TRACK, 18
boot:
jmp	start
    nop ;# <-*** THIS NEEDS TO BE HERE TO BE RECOGNIZED AS FLOPPY BY BIOS
    .org 0x3 ;# just insurance
    .ascii "cmcf 1.0"
;# start DOS 2.0 BPB, offset 0xb
bps:
    .word 512       ;# bytes/sector
    .byte 1         ;# sector/cluster
    .word 1         ;# sector reserved
    .byte 0         ;# fats, normally 2, can be 0
    .word 0         ;# root directory entries
    .word 80 * HEADS * SECTORS_PER_TRACK ;# sectors
    .byte 0xf0      ;# media
    .word SECTORS_PER_TRACK / 2 ;# sectors/fat, normally 9, can be 0
;# start of DOS 3.31 BPB, offset 0x18
spt:
    .word SECTORS_PER_TRACK ;# sectors/track
heads:
    .word HEADS     ;# heads
    .long 0         ;# hidden sectors
    .long 2880      ;# total sectors, can be zero
;# start of DOS 4.0 EBPB, offset 0x24
drive:
    .byte 0         ;# physical drive number
    .byte 0         ;# flags etc.
    .byte 0x28      ;# extended boot signature, 0x28=4.0
    .long 0x0       ;# volume serial number
    .ascii "           " ;# volume label
    .ascii "FAT12   " ;# filesystem type <-*** ALSO MUST BE HERE
start:
    mov ah, 0x0e    ;# show character
    mov al, dl      ;# get drive number
    or al, 'A'      ;# change to drive letter
    xor bx, bx      ;# bh=page 0; bl=color or attribute
    int 0x10        ;# BIOS function to show character in al
    hlt
;# ctrl-alt-del will reboot, since interrupts are enabled
    .org 0x1fe
    .byte 0x55, 0xaa ;# boot signature
;# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
