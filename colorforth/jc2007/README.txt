In an attempt to simplify the colorForth bootcode, I am making the
following changes:

* using unreal mode to allow BIOS calls while having use of 32-bit registers
* doing all floppy I/O using BIOS calls
? using a text video mode rather than bitmapped graphics
  (did that, but only during startup)
? not creating a .com file, just a floppy image, avoiding MS-DOS problems
  (saved it for later, but am working on color.com now that BIOS stuff works)

This will hopefully, eventually, eliminate the weirdness that causes the 
binaries to fail on QEMU, Bochs, and VMWare. As of this version, there are
still problems with VMWare at least. I've gotten this version to run on QEMU,
and it does so very fast. I haven't gotten it to boot natively on a desktop
from a floppy, and would appreciate any feedback from others who attempt this.

Programmer's notes:

* this Forth doesn't actually put the top stack element ON the stack; it leaves
  it in EAX. So, if you want a routine to return something on the data stack,
  FIRST do a 'dup' to save what's in EAX to the stack; then load EAX with
  whatever and return.

* to make programs compatible with 640x480, 800x600, and 1024x768 video modes,
  use constants "vp", "hp", "iw", and "ih" now available in high-level Forth.

* to make programs compatible with the load offset, which in this version is
  no longer 0, use "off" (in 32-bit words) or "off 4 *" (in bytes).

* running the color.com file from DOS only loads 64K, so blocks beyond that
  will not be accessible. this means all the community code blocks unless
  they are moved down into CM's reserved area.

* when you see executable words in the sources other than 'macro', 'forth',
  'load', and the like, you may wonder what happens to what they put on the
  stack. for example, 'cf2ansi color.com | grep "1;33"' will show you several
  such words, including 'wc 18 blks ;', where the 18 and blks are both
  yellow (executed). what happens to the number pushed onto the stack? it
  is compiled as a literal. when the 'load' loop reaches the semicolon, it
  sees it's compiled (since the tagbits are 4), and calls qcompile. the first
  thing qcompile does is to call [lit], which calls alit, which falls into
  literal, which compiles 'mov eax, N', with N being the number pulled off
  the stack. if you need more than one such number compiled in a row, use a
  compiled 'nop' between them, such as you see in the source for 'pad'.

* register usage: ebp, and ebx are normally safe to use. edi is used as
  a word pointer into the sources when compiling with 'load'. esi is the data
  stack pointer, and eax contains the top element of the stack (see above).
  esp of course is the return stack pointer. edx is used as an address
  register, whatever that means, not sure when/if it's ever safe to use without
  saving it. ecx is sometimes safe but it may be wise to save that too.

* after running 'make qemu', remember that the b.img you modified with 'save'
  may be located in a different directory than you might expect. find all
  copies and check timestamps.

* inserting a 'hlt' into bootcode will enable you to see if VMWare reached it,
  'grep halt ../test/vmware.log'

UPDATE
------
* see http://unternet.net/src, especially src/clusterFix, for some experiments
  with ColorForth2, ArrayForth, including being able to boot from a USB drive.

BUGS
----
* 2015-12-30: running in dosbox goes to fullscreen but total black. this is
    not so much a bug in either software, but something (linear framebuffer)
    that has not yet been implemented in dosbox.

John Comeau <jc@unternet.net>
