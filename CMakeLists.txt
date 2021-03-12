cmake_minimum_required(VERSION 3.16)

# create a new C project
project(DD2358-lab2 VERSION 1.0
                    DESCRIPTION "DD2358 Language Lab"
                    LANGUAGES C Fortran CXX)

# set C compiler
set(CMAKE_C_COMPILER gcc)
set(CMAKE_FORTRAN_COMPILER gfortran)
set(CMAKE_CXX_COMPILER g++)

find_package(Python COMPONENTS Interpreter Development REQUIRED)
find_package(pybind11 CONFIG REQUIRED)
pybind11_add_module(matrix
    gemm.cpp)

add_library(cmat SHARED 
    ./matrix.c)

set_target_properties(cmat PROPERTIES PUBLIC_HEADER ./matrix.h)

# add the source files that are needed to build an exe
add_executable(gemm_test.out # our executable is the target
    gemm_test.f90
    matrix.f90)

# set output target
set_target_properties(cmat matrix gemm_test.out
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "output/"
    LIBRARY_OUTPUT_DIRECTORY "output/"
    RUNTIME_OUTPUT_DIRECTORY "output/"
)
set_target_properties(gemm_test.out
    PROPERTIES
    Fortran_MODULE_DIRECTORY "output/"
)

# set link libraries for targets
target_link_libraries(gemm_test.out PRIVATE cmat)
target_link_libraries(matrix PRIVATE cmat)

# define header file path
target_include_directories(cmat PRIVATE .)

# set to use C11 features
target_compile_features(cmat PRIVATE c_std_11)

# set compiler options
target_compile_options(cmat PRIVATE -Wall -O3)

configure_file(run_matrix.py output/run_matrix.py COPYONLY)