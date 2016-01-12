
fdboot.mbr:     file format binary


Disassembly of section .data:

00000000 <.data>:
   0:	jmp    0x3e
   2:	nop
   3:	dec    sp
   4:	dec    cx
   5:	dec    si
   6:	push   bp
   7:	pop    ax
   8:	xor    al,0x2e
   a:	xor    WORD PTR [bx+si],ax
   c:	add    al,BYTE PTR [bx+di]
   e:	add    WORD PTR [bx+si],ax
  10:	add    ah,al
  12:	add    BYTE PTR [bx+si+0xb],al
  15:	lock or WORD PTR [bx+si],ax
  18:	adc    al,BYTE PTR [bx+si]
  1a:	add    al,BYTE PTR [bx+si]
	...
  24:	add    BYTE PTR [bx+si],al
  26:	sub    bx,sp
  28:	jg     0x24
  2a:	inc    sp
  2b:	and    BYTE PTR [bx+si],ah
  2d:	and    BYTE PTR [bx+si],ah
  2f:	and    BYTE PTR [bx+si],ah
  31:	and    BYTE PTR [bx+si],ah
  33:	and    BYTE PTR [bx+si],ah
  35:	and    BYTE PTR [bp+0x41],al
  38:	push   sp
  39:	xor    WORD PTR [bp+si],si
  3b:	and    BYTE PTR [bx+si],ah
  3d:	and    dl,bh
  3f:	cld    
  40:	xor    ax,ax
  42:	mov    ds,ax
  44:	mov    bp,0x7c00
  47:	mov    ax,0x1fe0
  4a:	mov    es,ax
  4c:	mov    si,bp
  4e:	mov    di,bp
  50:	mov    cx,0x100
  53:	rep movs WORD PTR es:[di],WORD PTR ds:[si]
  55:	jmp    0x1fe0:0x7c5e
  5a:	add    BYTE PTR [bx+si],al
  5c:	pusha  
  5d:	add    BYTE PTR [bp-0x7128],cl
  61:	ror    BYTE PTR [di-0x5f9a],1
  65:	sti    
  66:	cmp    BYTE PTR [bp+0x24],0xff
  6a:	jne    0x6f
  6c:	mov    BYTE PTR [bp+0x24],dl
  6f:	mov    WORD PTR [bp-0x40],0x10
  74:	mov    WORD PTR [bp-0x3e],0x1
  79:	call   0x165
  7c:	inc    si
  7d:	jb     0xe4
  7f:	gs inc sp
  81:	dec    di
  82:	push   bx
  83:	add    BYTE PTR [bp+di+0x1c76],cl
  87:	mov    di,WORD PTR [bp+0x1e]
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
 14b:	call   0x165
 14e:	and    BYTE PTR [di+0x72],ah
 151:	jb     0x153
 153:	xor    ah,ah
 155:	int    0x16
 157:	int    0x19
 159:	mov    bl,BYTE PTR [bp+0x24]
 15c:	jmp    DWORD PTR [bp+0x5a]
 15f:	xor    bx,bx
 161:	mov    ah,0xe
 163:	int    0x10
 165:	pop    si
 166:	lods   al,BYTE PTR ds:[si]
 167:	push   si
 168:	cmp    al,0x0
 16a:	jne    0x15f
 16c:	ret    
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
 1fe:	push   bp
 1ff:	stos   BYTE PTR es:[di],al
