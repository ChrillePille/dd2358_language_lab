# dd2358_language_lab

## Set-up
I built this on WSL with cmake using gcc, gfortran, g++, anaconda (Anaconda3-5.3.1-Linux-x86_64), with an anaconda virtual environment as laid out in the cross-language tutorial, installing numpy, cython, and pybind11 in the virtual environment.

To prepare for building the project, invoke
```
$ mkdir build
$ cd build
$ cmake ..
```
after which you simply invoke
```
$ make
```
in the `build/` directory to build all parts 1 - 3 of the assignment.

## Part 1: `libcmat.so`
`libcmat.so` is the shared library compiled from `matrix.c`, and can now be used to compile the next parts. 

## Part 2: `gemm_test.out`
`gemm_test.out` is compiled from `gemm_test.f90`, `matrix.f90`, and `libcmat.so`, also producing a fortran module file `matrix.mod`.

## Part 3: `matrix.so`
The python module file `matrix.so` is compiled as `matrix.<python_config>.so`, and can be imported as `matrix` to python code. Test the file `run_matrix.py` by doing something like the following:
```
$ cd output
$ python3 run_matrix.py
```

Invoke `make clean` to purge output files, or just `rm -r build` and rebuild cmake.