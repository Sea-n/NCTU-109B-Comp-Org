#!/usr/bin/env python3

import sys
from numpy import int32
from numpy.random import randint, choice


def main():
    T = 62
    if len(sys.argv) == 2:
        T = int(sys.argv[1])

    fop = open('testcase/op.txt', 'w')
    fsrc1 = open('testcase/src1.txt', 'w')
    fsrc2 = open('testcase/src2.txt', 'w')
    fres = open('testcase/result.txt', 'w')
    fzcv = open('testcase/zcv.txt', 'w')
    fsummary = open('testcase/summary.txt', 'w')

    for t in range(1, T+1):
        op = choice([0b0000, 0b0001, 0b0010, 0b0110, 0b1100, 0b0111])
        src1 = randint(0xFFFFFFFF)
        src2 = randint(0xFFFFFFFF)
        res = 0
        zcv = 0

        if op == 0b0000:  # AND
            res = src1 & src2

        if op == 0b0001:  # OR
            res = src1 | src2

        if op == 0b0010:  # ADD
            res = src1 + src2

            if src1 & 0x80000000:
                if src2 & 0x80000000:
                    if not res & 0x80000000:
                        zcv |= 0b001
            else:
                if not src2 & 0x80000000:
                    if res & 0x80000000:
                        zcv |= 0b001

        if op == 0b0110:  # SUB
            res = src1 + (-src2 & 0xFFFFFFFF)

            if src1 & 0x80000000:
                if not src2 & 0x80000000:
                    if not res & 0x80000000:
                        zcv |= 0b001
            else:
                if src2 & 0x80000000:
                    if res & 0x80000000:
                        zcv |= 0b001

        if op == 0b1100:  # NOR
            res = ~(src1 | src2) & 0xFFFFFFFF

        if op == 0b0111:  # SLT
            res = 1 if int32(src1) < int32(src2) else 0

        if res & 0x100000000:
            zcv |= 0b010

        if res == 0:
            zcv |= 0b100

        res &= 0xFFFFFFFF

        src1 = ('00000000' + hex(src1)[2:])[-8:]
        src2 = ('00000000' + hex(src2)[2:])[-8:]
        res = ('00000000' + hex(res)[2:])[-8:]

        fop.write('%1x\n' % op)
        fsrc1.write(fold(src1))
        fsrc2.write(fold(src2))
        fres.write(fold(res))
        fzcv.write('%1x\n' % zcv)
        fsummary.write(f'Case #{t}: {src1} <{op}> {src2} = {res}, {zcv}\n')

    fop.close()
    fsrc1.close()
    fsrc2.close()
    fres.close()
    fzcv.close()
    fsummary.close()


def fold(dword):
    ret = ''
    ret += dword[6:8] + '\n'
    ret += dword[4:6] + '\n'
    ret += dword[2:4] + '\n'
    ret += dword[0:2] + '\n'
    return ret


if __name__ == '__main__':
    main()
