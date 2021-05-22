_00:     addi   r1, r0, 1    // r1 = 1
_04:     addi   r2, r0, 2    // r2 = 2
_08:     addi   r3, r0, 3    // r3 = 3
_0C:     addi   r4, r0, 4    // r4 = 4
_10:     addi   r5, r0, 5    // r5 = 5
_14:     jump   j
_18:     addi   r1, r0, 31   // 若 jump 對
_1C:     addi   r2, r0, 63   // 這兩個 addi 將不會執行

_20: j:  sw     r1, 0(r0)    // m0 = 1
_24:     sw     r2, 4(r0)    // m1 = 2
_28:     lw     r6, 0(r0)    // r6 = 1
_2C:     lw     r7, 0(r4)    // r7 = 2
_30:     add    r8, r1, r3   // r8 = 4
_34:     lw     r9, 4(r0)    // r9 = 2



# Memory
m0 =    1, m1 =    2

# Register
r1 =    1, r2 =    2, r3 =    3, r4 =    4, r5 =    5
r6 =    1, r7 =    2, r8 =    4, r9 =    2, r29=  128
