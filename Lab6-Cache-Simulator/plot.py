#!/usr/bin/env python3
import matplotlib.pyplot as plt
from subprocess import run, PIPE


def drawA():
    x = [str(2**i) + ' bytes' for i in range(3, 8)]
    z = [str(2**i) + ' KB' for i in range(2, 6)] + ['512 KB']

    for c in z:
        val = []
        for b in x:
            v = run(['./cache_simulator', '-f', 'Trace.txt', '-c', c,
                     '-b', b, '-a', '1', '-p', '4'], stdout=PIPE)
            val.append(float(v.stdout))
        plt.plot(x, val, marker='o', label=c)
        print(c, val)

    plt.legend(title='Cache size', loc='upper right')
    plt.title('Associativity = 1 (direct map cache)')
    plt.xlabel('Block size')
    plt.ylabel('Miss rate')
    plt.ylim(0, 30)
    plt.xticks(x)

    plt.savefig('figure1.png')
    plt.cla()


def drawB():
    x = [str(2**i) + '-way' for i in range(3)] + ['32-way']
    z = [str(2**i) + ' KB' for i in range(6)] + ['512 KB']

    for c in z:
        val = []
        for a in x:
            v = run(['./cache_simulator', '-f', 'Trace.txt', '-c', c,
                     '-b', '32', '-a', a, '-p', '4'], stdout=PIPE)
            val.append(float(v.stdout))
        plt.plot(x, val, marker='o', label=c)
        print(c, val)

    plt.legend(title='Cache size', loc='upper right')
    plt.title('Block Size = 32 bytes')
    plt.xlabel('Associativity')
    plt.ylabel('Miss rate')
    plt.ylim(0, 30)
    plt.xticks(x)

    plt.savefig('figure2.png')
    plt.cla()


def drawC():
    w = [str(2**i) + ' KB' for i in range(3, 6)] + ['512 KB']
    x = [str(2**i) + ' bytes' for i in range(3, 9)]
    z = [str(2**i) + '-way' for i in range(4)]

    for c in w:
        for a in z:
            val = []
            for b in x:
                v = run(['./cache_simulator', '-f', 'Trace.txt', '-c', c,
                         '-b', b, '-a', a, '-p', '4'], stdout=PIPE)
                val.append(float(v.stdout))
            plt.plot(x, val, marker='o', label=a)
            print(a, val)

        plt.legend(title='Associativity', loc='upper right')
        plt.title(f'Cache Size = {c}')
        plt.xlabel('Block size')
        plt.ylabel('Miss rate')
        plt.ylim(0, 30)
        plt.xticks(x)

        plt.savefig(f'figure3-{c}.png')
        plt.cla()


def main():
    plt.figure(dpi=320)
    drawA()
    drawB()
    drawC()


if __name__ == '__main__':
    main()
