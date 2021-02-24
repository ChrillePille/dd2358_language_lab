CC = gcc
FC = gfortran
CPP = g++
PY = python3

part_1: libmatrix

part_2: gemm_fortran

part_3: gemm_pybind

matrix: matrix.c
	$(CC) -c matrix.c -o matrix.o 

libmatrix: matrix.c
	$(CC) -Wall -fPIC -shared -o libmatrix.so matrix.c 

gemm_fortran: matrix gemm_code.f90
	$(FC) -c gemm_code.f90 -o gemm_f.o
	$(FC) matrix.o gemm_f.o -o gemm_f_main.out
	rm matrix.o
	rm gemm_f.o

gemm_pybind: libmatrix.so gemm.cpp
	$(CPP) -O3 -Wall -shared -std=c++11 -fPIC `python3 -m pybind11 --includes` libmatrix.so gemm.cpp -o matrix.so

run_matrix: matrix.so run_matrix.py
	$(PY) run_matrix.py

clean:
	rm -f *.o
	rm -f *.so
	rm -f *.out