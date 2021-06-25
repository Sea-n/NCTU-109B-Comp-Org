import matplotlib.pyplot as plt
from subprocess import run, PIPE


def drawA():
    x = [str(2**i) for i in range(1, 6)]

    for c in [64, 128, 256, 512]:
        val = []
        for b in x:
            v = run(["./cache_simulator", "-f", "Trace.txt", "-c", str(c),
                     "-b", str(b), "-a", "1", "-d", "4"], stdout=PIPE)
            val.append(float(v.stdout))
        print("c=", c, "val=", val)
        plt.plot(x, val, marker="o", label=c)

    plt.title("Associativity = direct_map_cache")
    plt.xlabel("Block size (byte)")
    plt.ylabel("Miss rate")
    plt.xticks(x)
    plt.ylim(0, 15)
    plt.legend(title="Cache size (KB)")

    plt.show()


def drawB():
    x = [str(2**i) + "-way" for i in range(4)]

    for c in [str(2**i) for i in range(6)]:
        val = []
        for a in x:
            v = run(["./cache_simulator", "-f", "Trace.txt", "-c", str(c),
                     "-b", "32", "-a", a, "-d", "4"], stdout=PIPE)
            val.append(float(v.stdout))
        print("c=", c, "val=", val)
        plt.plot(x, val, marker="o", label=c)

    plt.title("Block size = 32 byte")
    plt.xlabel("Associativity")
    plt.ylabel("Miss rate")
    plt.xticks(x)
    plt.ylim(0, 25)
    plt.legend(title="Cache size (KB)")

    plt.show()


drawA()
drawB()
