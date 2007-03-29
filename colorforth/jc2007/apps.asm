BLOCK 64
FORTH [TEXTCAPITALIZED], mandelbrot, [TEXT], display, [EXECUTE], empty, [EXECUTE], forth, [VARIABLE], xl, [BINARY], 0, [VARIABLE], xr, [BINARY], 0, [VARIABLE], yt, [BINARY], 0, [VARIABLE], yb, [BINARY], 0, [VARIABLE], xspan, [BINARY], 0, [VARIABLE], yspan, [BINARY], 0, [VARIABLE], xnow, [BINARY], 0, [VARIABLE], ynow, [BINARY], 0, [VARIABLE], flag, [BINARY], 0, [VARIABLE], dark, [BINARY], 0, [VARIABLE], pause, [BINARY], 0
FORTH allot, [TEXT], n-a, here, [COMPILESHORT], 3, +, [COMPILESHORT], 4, /, swap, for, 0, ",", next, ";", [VARIABLE], z, [BINARY], 0, [EXECUTE], hp, [EXECUTE], vp, [EXECUTE], "*", [EXECUTE], [EXECUTESHORT], 1, [EXECUTE], +, [EXECUTE], dup, [EXECUTE], "+", [EXECUTE], allot, [EXECUTE], z, [EXECUTE], "!" 
FORTH fixed, [EXECUTELONGHEX], 10000000, [EXECUTESHORT], 1000, [EXECUTE], /, *, ";"
FORTH x, [EXECUTE], xnow, @, ";"
FORTH y, [EXECUTE], ynow, @, ";"
FORTH abs, 0, or, -if, negate, then, ";"
FORTH ge4, [TEXT], n-,
 FORTH [COMPILESHORT], [EXECUTESHORT], -4000, [EXECUTE], fixed,
 FORTH [COMPILEWORD], +, drop, -if, ";", then,
 FORTH [EXECUTE], flag, dup, !, ";"
FORTH zge4, [TEXT], a-,
 FORTH [COMPILEWORD], dup, @, ge4, dup, [COMPILESHORT], 1, +, @, ge4,
 FORTH [COMPILEWORD], dup, @, dup, fx*, dup, ge4,
 FORTH [COMPILESHORT], 1, +, @, dup, fx*, dup, ge4,
 FORTH [COMPILEWORD], fx*, ge4, ";"
FORTH z0, [TEXT], -a, [EXECUTE], z, @, vp, hp, *, dup, +, +, ";"
FORTH xval, x, [COMPILELONGHEX], 10000000, hp, "*/", ;# scale to A(3,28) fixed
 FORTH [EXECUTE], xspan, @, fx*, [EXECUTE], xl, @, +, ";"
FORTH yval, y, [COMPILELONGHEX], 10000000, vp, "*/", ;# make fixed-point number
 FORTH [EXECUTE], yspan, @, fx*, negate, [EXECUTE], yt, @, +, ";"
FORTH check, over, over, ;# leave two items on the stack
 FORTH [COMPILESHORT], 3, [COMPILESHORT], 200, at, h., space, h., ";"
FORTH xnext, x, [COMPILESHORT], 200, +, hp, mod, [EXECUTE], xnow, !, ";"
FORTH p, [EXECUTE], pause, dup, @,
 FORTH [COMPILESHORT], 1, or, swap, !, ";" ;# toggle
FORTH pnext,  ;#xval, yval, check, drop, drop,
 ;#FORTH [COMPILEWORD], x, y, check, drop, drop,
 FORTH [COMPILEWORD], xnext,
 FORTH [COMPILEWORD], x, 0, +, drop, if, ";", # done if x nonzero
 FORTH [COMPILEWORD], then, y, [COMPILESHORT], 1, +, vp, mod, ;# increment y
 FORTH [EXECUTE], ynow, "!", ";"
FORTH [EXECUTESHORT], 66, [EXECUTE], load

BLOCK 65
FORTH allot, grabs, space, at, [COMPILEWORD], here, and, returns, that, "address;", z, points, to, the, array, of, values, as, generated, by, "z**2+z0"
FORTH [TEXT], xl, xr, yt, yb, are, the, start, limits, mapped, by, the, [TEXTCAPITALIZED], cartesian, "grid;", xspan, and, yspan, hold, the, x, and, y, ranges
FORTH z0, we, left, an, extra, space, at, end, of, [COMPILEWORD], z, array, for, z0, [TEXTALLCAPS], aka, c, in, z**2+c
FORTH z**2, the, square, of, complex, number, "a,", "b", is,  a**2, -, b**2, ",", 2a*b
FORTH iter, iterates, over, the, array, updating, continuously
FORTH init, initializes, variables
FORTH ok, sets, the, display, and, starts, the, generator

BLOCK 66
FORTH z**2, [TEXT], a-a, [EXECUTE], flag, 0, !, ;# clear overrun flag
 FORTH [COMPILEWORD], dup, dup, @, over, [COMPILESHORT], 1, +, @, ;# -axy
 FORTH [COMPILEWORD], over, dup, fx*, if, ;# x**2 too big to fit 3 bits
 FORTH [EXECUTE], flag, dup, !, then, ;# anything nonzero is a "yes"
 FORTH [COMPILEWORD], over, dup, fx*, if, ;# y**2 too big
 FORTH [EXECUTE], flag, dup, !, then,
 FORTH [COMPILEWORD], negate, +, push,
 FORTH [COMPILEWORD], fx*, if, ;# x*y too big
 FORTH [EXECUTE], flag, dup, !, then, 2*,
 FORTH [COMPILEWORD], over, [COMPILESHORT], 1, +, !, pop, swap, !, ";"
FORTH z+, [TEXT], aa-, ;# add two complex numbers, storing result in first
 FORTH [COMPILEWORD], over, [COMPILESHORT], 1, +, @, ;# -aav
 FORTH [COMPILEWORD], over, [COMPILESHORT], 1, +, @, ;# -aavv
 FORTH [COMPILEWORD], +, push, over, pop, swap, [COMPILESHORT], 1, +, !,
 FORTH [COMPILEWORD], @, over, @, +, swap, !, ";"
FORTH iter, ;# iterate through the array of complex numbers, updating
 ;# this does one pixel at a time
 FORTH [EXECUTE], pause, @, 0, +, drop, if, ";", then,
 FORTH [COMPILESHORT], -8, [EXECUTE], dark, !,
 FORTH [COMPILEWORD], xval, z0, !, yval, z0, [COMPILESHORT], 1, +, !,
 FORTH [COMPILEWORD], x, y, hp, *, +, ;# 0-based pixel
 FORTH [COMPILEWORD], dup, 2*, ;# doubled for z-table, single for display
 FORTH [COMPILEWORD], pnext,
 FORTH [EXECUTE], z, @, +, dup, zge4, dup, z**2, zge4,
 FORTH [EXECUTE], flag, @, 0, +, drop, if, 0, [EXECUTE], dark, !,
 FORTH [COMPILEWORD], then, z0, z+, ;# z is now z**2+z0
 FORTH [COMPILEWORD], 2/, vframe, +, [EXECUTE], dark, @, swap, +!, ";"
FORTH init, [TEXT], -2.1,
 FORTH [EXECUTESHORT], -2100, [EXECUTE], fixed, nop, [EXECUTE], xl, "!",
 FORTH [TEXT], "1.1",
 FORTH [EXECUTESHORT], 1100, [EXECUTE], fixed, nop, [EXECUTE], xr, "!",
 FORTH [TEXT], "1.2",
 FORTH [EXECUTESHORT], 1200, [EXECUTE], fixed, nop, [EXECUTE], yt, "!",
 FORTH [TEXT], "-1.2",
 FORTH [EXECUTESHORT], -1200, [EXECUTE], fixed, nop, [EXECUTE], yb, "!",
 FORTH [EXECUTE], xr, "@", [EXECUTE], xl, "@", negate, "+",
 FORTH [EXECUTE], xspan, "!",
 FORTH [EXECUTE], yt, "@", [EXECUTE], yb, "@", negate, "+",
 FORTH [EXECUTE], yspan, "!",
 FORTH [COMPILEWORD], ";"
;# put "show" before "blue, screen" for debugging; after for raster graphics
FORTH ok, init, blue, screen, show, keyboard, debug, iter, ";"
BLOCK
