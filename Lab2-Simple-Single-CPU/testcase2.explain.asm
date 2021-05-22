_00:  addi r6, r0, 2   // r6 = 2
_04:  addi r7, r0, 14  // r7 = 14
_08:  and  r8, r6, r7  // r8 = r6 & r7
_0C:  or   r9, r6, r7  // r9 = r6 | r7
_10:  addi r6, r6, -1  // r6 = r6 - 1
_14:  slti r1, r6, 1   // r1 = r6 < 1
_18:  beq  r1, r0, -5  // if (r1 = 0)
