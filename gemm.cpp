extern "C" {
    #include "matrix.h"
}
#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
//#include <iostream>

namespace py = pybind11;

void gemm(py::array_t<float> py_c, const py::array_t<float> py_a, const py::array_t<float> py_b) {
    // needed for sanity checks
    py::buffer_info a_buffer = py_a.request();
    py::buffer_info b_buffer = py_b.request();
    py::buffer_info c_buffer = py_c.request();
    
    // check # of dims
    if (a_buffer.ndim != 2) {
        throw std::runtime_error("error: a is not a matrix");
    }
    if (b_buffer.ndim != 2) {
        throw std::runtime_error("error: b is not a matrix");
    }
    if (c_buffer.ndim != 2) {
        throw std::runtime_error("error: c is not a matrix");
    }

    // check shape match
    if (a_buffer.shape[1] != b_buffer.shape[0]) {
        throw std::runtime_error("error: a and b dimension mismatch");
    }
    if (a_buffer.shape[0] != a_buffer.shape[1]) {
        throw std::runtime_error("error: a is not a square matrix");
    }
    if (b_buffer.shape[0] != b_buffer.shape[1]) {
        throw std::runtime_error("error: b is not a square matrix");
    }
    if (c_buffer.shape[0] != c_buffer.shape[1]) {
        throw std::runtime_error("error: c is not a square matrix");
    }
    if (a_buffer.shape[0] != c_buffer.shape[0] || b_buffer.shape[1] != c_buffer.shape[1]) {
        throw std::runtime_error("error: shape mismatch between a, b, and c");
    }

    // get pointers to internal buffers
    float *a = (float*)a_buffer.ptr;
    float *b = (float*)b_buffer.ptr;
    float *c = (float*)c_buffer.ptr;

    // get bound
    int n = a_buffer.shape[1];

    // do matmul (now in c!)
    c_mat_mul(n, c, a, b);


    // do matmul in cpp
    //float s;
    //for (int i = 0; i < i_bound; i++) {
    //    for (int j = 0; j < j_bound; j++) {
    //        s = 0.0;
    //        for (int k = 0; k < k_bound; k++) {
    //            s += a[i*i_bound + k] * b[k*k_bound + j];
    //        }
    //        std::cout << "s: " << s << "\n";
    //        c[i*i_bound + j] = s;
    //    }
    //}
}

PYBIND11_MODULE(matrix, m) {
    m.def("gemm", &gemm);
}