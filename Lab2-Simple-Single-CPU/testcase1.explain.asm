_00:  addi r1, r0, 10  // r1 = 10
_04:  addi r2, r0, 4   // r2 = 4
_08:  slt  r3, r1, r2  // r3 = r1 < r2 = false
_0c:  beq  r3, r0, 1   // if (r3 = 0)
_10:  add  r4, r1, r2  // r4 = r1 + r2 = 14
_14:  sub  r5, r1, r2  // r5 = r1 - r2 = 6
