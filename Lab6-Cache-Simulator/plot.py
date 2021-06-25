#!/usr/bin/env python3
import matplotlib.pyplot as plt
from subprocess import run, PIPE


def drawA():
    x = [str(2**i) + ' bytes' for i in range(3, 8)]
    z = [str(2**i) + ' KB' for i in range(2, 7)]

    for c in z:
        val = []
        for b in x:
            v = run(['./cache_simulator', '-f', 'Trace.txt', '-c', c,
                     '-b', b, '-a', '1', '-p', '4'], stdout=PIPE)
            val.append(float(v.stdout))
        plt.plot(x, val, marker='o', label=c)
        print(c, val)

    plt.legend(title='Cache size', loc='upper right')
    plt.title('Associativity = direct_map_cache')
    plt.xlabel('Block size')
    plt.ylabel('Miss rate')
    plt.ylim(0, 30)
    plt.xticks(x)

    plt.savefig('figure1.png')
    plt.cla()


def drawB():
    x = [str(2**i) + '-way' for i in range(4)]
    z = [str(2**i) + ' KB' for i in range(6)]

    for c in z:
        val = []
        for a in x:
            v = run(['./cache_simulator', '-f', 'Trace.txt', '-c', c,
                     '-b', '32', '-a', a, '-p', '4'], stdout=PIPE)
            val.append(float(v.stdout))
        plt.plot(x, val, marker='o', label=c)
        print(c, val)

    plt.legend(title='Cache size', loc='upper right')
    plt.title('Block size = 32 byte')
    plt.xlabel('Associativity')
    plt.ylabel('Miss rate')
    plt.ylim(0, 30)
    plt.xticks(x)

    plt.savefig('figure2.png')


def main():
    plt.figure(dpi=320)
    drawA()
    drawB()


if __name__ == '__main__':
    main()
