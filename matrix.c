#include <stdio.h>
#include "matrix.h"

void c_mat_mul(int n, int *c, int *a, int *b) {
    int i, j, k, s;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            s = 0;
            for (k = 0; k < n; k++) {
                //s = s + a[i][k] * b[k][j]; //c-style arrays, don't work with column major memory allocation
                s = s + *(a + i + k*n) * *(b + j*n + k); // this works for column major memory allocation
            }
            *(c + i + j*n) = s;
        }
    }
}

void np_matmul(float *c, float *a, float *b, const int i_bound, const int j_bound, const int k_bound) {
    float s;
    int i, j, k;
    for (i = 0; i < i_bound; i++) {
        for (j = 0; j < j_bound; j++) {
            s = 0.0;
            for (k = 0; k < k_bound; k++) {
                s += *(a + i*i_bound + k) * *(b + k*k_bound + j);
            }
            *(c + i*i_bound + j) = s;
        }
    }
}