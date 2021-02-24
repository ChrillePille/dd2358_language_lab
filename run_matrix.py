import numpy as np
import matrix as mat

if __name__ == '__main__':
    print("Generate random 10x10 matrices a, b, and compute c = a*b\n")
    # Init matrices
    a = np.random.random([10,10]).astype(np.float32)
    b = np.random.random([10,10]).astype(np.float32)
    c = np.zeros([10,10], dtype=np.float32)
    # Show matrices
    # print(a)
    # print(b)
    # Write c = a*b
    mat.gemm(c, a, b)
    # Show c
    # print(c)
    # Control solution
    control = np.dot(a, b)
    # Did it produce a good result?
    if np.allclose(c, control):
        print("Correct solution c = a*b\n")
    else:
        print("Incorrect solution c = a*b\n")