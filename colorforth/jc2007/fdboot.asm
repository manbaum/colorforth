;# freedos bootblock disassembly
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
    .byte 2         ;# fats, normally 2, can be 0
    .word 224       ;# root directory entries
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
    .byte 0         ;# physical drive number
    .byte 0         ;# flags etc.
    .byte 0x29      ;# extended boot signature, 0x29=4.1 (?)
    .long 0x44fa7fe3 ;# volume serial number
;# the above serial number is probably freedos's timestamp:
;# $ printf '%d\n' 0x44fa7fe3
;# 1157267427
;# $ python
;# >>> datetime.datetime.fromtimestamp(1157267427)
;# datetime.datetime(2006, 9, 3, 0, 10, 27)
    .ascii "           " ;# volume label
    .ascii "FAT12   " ;# filesystem type <-*** ALSO MUST BE HERE
start:
    cli ;# no interrupts during relocation
    cld ;# make sure we're moving down-to-up
    xor ax, ax
    mov ds, ax
    mov bp, 0x7c00 ;# from 0:7c00
    mov ax,0x1fe0 ;# to 1fe0:7c00, or 0x27a00
    mov es, ax
    mov si, bp
    mov di, bp
    mov cx, 0x100
    rep movs WORD PTR es:[di],WORD PTR ds:[si]
    jmp 0x1fe0:0x7c5e
    .word 0
    .word 0x60
start1:
    mov ds, ax
    mov ss, ax
    lea sp, [bp-0x60]
    sti ;# reenable interrupts
;# using just below bootblock, to top of stack, for local variables/workspace
    cmp BYTE PTR [bp+0x24],0xff ;# drive number
    jne skip
;# store number of bootdrive from DL:
;# https://en.wikibooks.org/wiki/X86_Assembly/Bootloaders#Technical_Details
    mov BYTE PTR [bp+0x24],dl
skip:
    mov WORD PTR [bp-0x40],0x10
    mov WORD PTR [bp-0x3e],0x1
    call outstring
    .asciz "FreeDOS"
continue:
    mov    si,WORD PTR [bp+0x1c]
    mov    di,WORD PTR [bp+0x1e]
  8a:	add    si,WORD PTR [bp+0xe]
  8d:	adc    di,0x0
  90:	mov    WORD PTR [bp-0x2e],si
  93:	mov    WORD PTR [bp-0x2c],di
  96:	mov    al,BYTE PTR [bp+0x10]
  99:	cbw    
  9a:	mul    WORD PTR [bp+0x16]
  9d:	add    si,ax
  9f:	adc    di,dx
  a1:	mov    WORD PTR [bp-0x2a],si
  a4:	mov    WORD PTR [bp-0x28],di
  a7:	mov    bx,WORD PTR [bp+0xb]
  aa:	mov    cl,0x5
  ac:	shr    bx,cl
  ae:	mov    ax,WORD PTR [bp+0x11]
  b1:	xor    dx,dx
  b3:	div    bx
  b5:	mov    WORD PTR [bp-0x30],ax
  b8:	add    si,ax
  ba:	adc    di,0x0
  bd:	mov    WORD PTR [bp-0x26],si
  c0:	mov    WORD PTR [bp-0x24],di
  c3:	mov    ax,WORD PTR [bp-0x2a]
  c6:	mov    dx,WORD PTR [bp-0x28]
  c9:	mov    di,WORD PTR [bp-0x30]
  cc:	les    bx,DWORD PTR [bp+0x5a]
  cf:	call   0x16d
  d2:	jb     0x103
  d4:	les    di,DWORD PTR [bp+0x5a]
  d7:	mov    cx,0xb
  da:	mov    si,0x7df1
  dd:	push   di
  de:	repz cmps BYTE PTR ds:[si],BYTE PTR es:[di]
  e0:	pop    di
  e1:	mov    ax,WORD PTR es:[di+0x1a]
  e5:	je     0xf2
  e7:	add    di,0x20
  ea:	cmp    BYTE PTR es:[di],0x0
  ee:	jne    0xd7
  f0:	jb     0x14b
  f2:	push   ax
  f3:	les    bx,DWORD PTR [bp+0x5a]
  f6:	mov    di,WORD PTR [bp+0x16]
  f9:	mov    ax,WORD PTR [bp-0x2e]
  fc:	mov    dx,WORD PTR [bp-0x2c]
  ff:	call   0x16d
 102:	pop    ax
 103:	jb     0x14b
 105:	push   ds
 106:	pop    es
 107:	mov    ds,WORD PTR [bp+0x5c]
 10a:	mov    di,0x2000
 10d:	stos   WORD PTR es:[di],ax
 10e:	mov    si,ax
 110:	add    si,si
 112:	add    si,ax
 114:	shr    si,1
 116:	lods   ax,WORD PTR ds:[si]
 117:	jae    0x11d
 119:	mov    cl,0x4
 11b:	shr    ax,cl
 11d:	and    ah,0xf
 120:	cmp    ax,0xff8
 123:	jb     0x10d
 125:	xor    ax,ax
 127:	stos   WORD PTR es:[di],ax
 128:	push   cs
 129:	pop    ds
 12a:	les    bx,DWORD PTR [bp+0x5a]
 12d:	mov    si,0x2000
 130:	lods   ax,WORD PTR ds:[si]
 131:	or     ax,ax
 133:	je     0x159
 135:	dec    ax
 136:	dec    ax
 137:	mov    di,WORD PTR [bp+0xd]
 13a:	and    di,0xff
 13e:	mul    di
 140:	add    ax,WORD PTR [bp-0x26]
 143:	adc    dx,WORD PTR [bp-0x24]
 146:	call   0x16d
 149:	jae    0x130
 14b:	call   outstring
    .asciz " err"
 153:	xor    ah,ah
 155:	int    0x16
 157:	int    0x19
 159:	mov    bl,BYTE PTR [bp+0x24]
 15c:	jmp    DWORD PTR [bp+0x5a]
outloop:
    xor bx, bx ;# white on black
    mov ah, 0xe ;# character to screen
    int 0x10 ;# BIOS service
outstring:
    pop si ;# string stored at return address, right after call
    lods al,BYTE PTR ds:[si] ;# load up the next byte
    push si
    cmp al, 0x0 ;# end of string?
    jne outloop
    ret ;# at this point the return address is just past the ASCIZ string
 16d:	push   si
 16e:	mov    WORD PTR [bp-0x38],ax
 171:	mov    WORD PTR [bp-0x36],dx
 174:	mov    WORD PTR [bp-0x3a],es
 177:	mov    WORD PTR [bp-0x3c],bx
 17a:	mov    ah,0x41
 17c:	mov    bx,0x55aa
 17f:	mov    dl,BYTE PTR [bp+0x24]
 182:	test   dl,dl
 184:	je     0x19f
 186:	int    0x13
 188:	jb     0x19f
 18a:	shr    cx,1
 18c:	sbb    bx,0xaa54
 190:	jne    0x19f
 192:	lea    si,[bp-0x40]
 195:	mov    WORD PTR [bp-0x34],bx
 198:	mov    WORD PTR [bp-0x32],bx
 19b:	mov    ah,0x42
 19d:	jmp    0x1cb
 19f:	mov    cx,WORD PTR [bp-0x38]
 1a2:	mov    dx,WORD PTR [bp-0x36]
 1a5:	mov    al,BYTE PTR [bp+0x18]
 1a8:	mul    BYTE PTR [bp+0x1a]
 1ab:	xchg   cx,ax
 1ac:	div    cx
 1ae:	xchg   dx,ax
 1af:	div    BYTE PTR [bp+0x18]
 1b2:	mov    cx,dx
 1b4:	mov    dh,al
 1b6:	xchg   cl,ch
 1b8:	ror    cl,1
 1ba:	ror    cl,1
 1bc:	mov    al,BYTE PTR [bp+0x18]
 1bf:	sub    al,ah
 1c1:	inc    ah
 1c3:	or     cl,ah
 1c5:	les    bx,DWORD PTR [bp-0x3c]
 1c8:	mov    ax,0x201
 1cb:	mov    dl,BYTE PTR [bp+0x24]
 1ce:	int    0x13
 1d0:	jae    0x1d8
 1d2:	xor    ah,ah
 1d4:	int    0x13
 1d6:	jmp    0x17a
 1d8:	mov    ax,WORD PTR [bp+0xb]
 1db:	div    BYTE PTR [bp-0x40]
 1de:	add    WORD PTR [bp-0x3a],ax
 1e1:	add    WORD PTR [bp-0x38],0x1
 1e5:	adc    WORD PTR [bp-0x36],0x0
 1e9:	dec    di
 1ea:	jne    0x1d6
 1ec:	mov    es,WORD PTR [bp-0x3a]
 1ef:	pop    si
 1f0:	ret    
 1f1:	dec    bx
 1f2:	inc    bp
 1f3:	push   dx
 1f4:	dec    si
 1f5:	inc    bp
 1f6:	dec    sp
 1f7:	and    BYTE PTR [bx+si],ah
 1f9:	push   bx
 1fa:	pop    cx
 1fb:	push   bx
 1fc:	add    BYTE PTR [bx+si],al
    .org 0x1fe
    .byte 0x55, 0xaa ;# boot signature
;# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
