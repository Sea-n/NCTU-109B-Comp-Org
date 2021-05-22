_00:        addi sp, sp, 0
_04:        addi a0, zero, 4       // f(4), 改變 r4 的值代表 f(r4)，若設太大可能要把 data memory 設大一些
_08:        addi t1, zero, 1
_0C:        jal  fib                // JAL: 當 fib function 結束後 PC 會跳到 j final
_10:        j    final

_14: fib:   addi sp, sp, -12       // stack pointer -= 12
_18:        sw   ra, 0(sp)           // 以下三道 sw 將 reg 存入 memory 中
_1C:        sw   s0, 4(sp)
_20:        sw   s1, 8(sp)
_24:        add  s0, a0, zero
_28:        beq  s0, zero, re1      // 判斷是否 f(0)
_2C:        beq  s0, t1, re1        // 判斷是否 f(1)
_30:        addi a0, s0, -1
_34:        jal  fib
_38:        add  s1, zero, v0       // s0 = f(n-1)
_3C:        addi a0, s0, -2
_40:        jal  fib                // v0 = f(n-2)
_44:        add  v0, v0, s1         // v0 = f(n-1) + f(n-2)

_48: exit:  lw   ra, 0(sp)
_4C:        lw   s0, 4(sp)
_50:        lw   s1, 8(sp)
_54:        addi sp, sp, 12
_58:        jr   ra                  // function call 結束

_5C: re1:   addi v0, zero, 1
_60:        j    exit

_64: final:  nop



# Register
r2  =   5, r9 =    1, r29=  128, r31=   16
