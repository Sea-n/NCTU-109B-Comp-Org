_00:  addi  r1, r0, 16   # r1 = 16
_04:  addi  r3, r0, 8    # r3 = 8
_08:  addi  r0, r0, 0    # nop
_0C:  addi  r2, r1, 4    # r2 = r1 + 4 = 20
_10:  sw    r1, 4(r0)    # A[1] = r1 = 16
_14:  lw    r4, 4(r0)    # r4 = A[1] = 16
_18:  add   r6, r3, r1   # r6 = r3 - r1 = -8
_1C:  addi  r7, r1, 10   # r7 = r1 + 10 = 26
_20:  sub   r5, r4, r3   # r5 = r4 - r3 = 8
_24:  addi  r9, r0, 100  # r9 = 100
_28:  and   r8, r7, r3   # r8 = r7 & r3 = 8


# Register
R0  =   0, R1  =  16, R2  =  20, R3  =   8, R4  =  16, R5  =   8, R6  =  24, R7  =  26
R8  =   8, R9  = 100, R10 =   0, R11 =   0, R12 =   0, R13 =   0, R14 =   0, R15 =   0
R16 =   0, R17 =   0, R18 =   0, R19 =   0, R20 =   0, R21 =   0, R22 =   0, R23 =   0
R24 =   0, R25 =   0, R26 =   0, R27 =   0, R28 =   0, R29 = 128, R30 =   0, R31 =   0

# Memory
m0  =   0, m1  =  16, m2  =   0, m3  =   0, m4  =   0, m5  =   0, m6  =   0, m7  =   0
m8  =   0, m9  =   0, m10 =   0, m11 =   0, m12 =   0, m13 =   0, m14 =   0, m15 =   0
r16 =   0, m17 =   0, m18 =   0, m19 =   0, m20 =   0, m21 =   0, m22 =   0, m23 =   0
m24 =   0, m25 =   0, m26 =   0, m27 =   0, m28 =   0, m29 =   0, m30 =   0, m31 =   0
