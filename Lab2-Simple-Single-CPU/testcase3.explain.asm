_00:  addi r2, r1, 31    // r2 = r1 + 31 = 30
_04:  addi r2, r2, -10   // r2 = r2 - 10 = 20
_08:  sub  r3, r0, r2    // r3 = -r2 = -20
_0c:  slt  r1, r3, r2    // r1 = r3 < r2
_10:  add  r7, r7, r1    // r7 = r7 + r1 = 1
_14:  slti r7, r7, -3    // r7 = r7 < -3
_18:  addi r8, r0, 20    // r8 = 20
_1c:  beq  r8, r2, _0x   // if r8 = r2
_20:  or   r9, r8, r2    // r9 = r8 | r2
_24:  addi r10, r2, -3   // r10 = r2 - 3
_28:  and  r11, r10, r2  // r11 = r10 & r2
