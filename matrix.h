#ifndef MATRIX_H
#define MATRIX_H

extern void c_mat_mul(int n, int *c, int *a, int *b);

extern void np_matmul(float *c, float *a, float *b, const int i_bound, const int j_bound, const int k_bound);

#endif