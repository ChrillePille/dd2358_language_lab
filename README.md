# dd2358_language_lab

## Set-up
I built this on WSL with gcc, gfortran, g++, anaconda (Anaconda3-5.3.1-Linux-x86_64), with an anaconda virtual environment as laid out in the cross-language tutorial, installing numpy, cython, and pybind11 in the virtual environment.

Look at the Makefile for exact specification of make commands.

## Part 1: `libmatrix.so`
Build `libmatrix.so` by invoking
```
make part_1
```
which invokes the `libmatrix` target, compiling `matrix.c` into the shared library `libmatrix.so`. 

## Part 2
Build `gemm_test.out` by invoking 
```
make part_2
```
which invokes the `gemm_fortran` target, compiling `matrix.c` and `gemm_code.f90` into and the `gemm_test.out` executable. Compiling `gemm_code.f90` also generates a '.mod' file for the `fort_matrix` module

## Part 3
Build the module by invoking
```make part_3```
which invokes the `libmatrix` and `gemm_pybind` targets. This builds the necessary `libmatrix.so` library, in order to compile the python module `matrix.so`.
After compiling the python module, we can test its performance by invoking
```make run_matrix```
which runs the test code written in `run_matrix.py`.