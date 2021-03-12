#include <stdio.h>
#include "matrix.h"

void c_mat_mul(int n, float *c, float *a, float *b) {
    int i, j, k;
    float s;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            s = 0.0f;
            for (k = 0; k < n; k++) {
                //s = s + a[i][k] * b[k][j]; //c-style arrays, don't work with column major memory allocation
                s = s + *(a + i*n + k) * *(b + k*n + j);
                //s = s + *(a + i + k*n) * *(b + j*n + k); // this works for column major memory allocation // NOT DOING THIS
            }
            *(c + i*n + j) = s;
        }
    }
}