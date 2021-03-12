cmake_minimum_required(VERSION 3.10)

# create a new C project
project(DD2358-lab2 VERSION 1.0
                    DESCRIPTION "DD2358 Language Lab part 1&2"
                    LANGUAGES C Fortran CXX)

# set C compiler
set(CMAKE_C_COMPILER gcc)
set(CMAKE_FORTRAN_COMPILER gfortran)
set(CMAKE_CXX_COMPILER g++)

find_package(pybind11 CONFIG)

add_library(matrix SHARED 
    ./matrix.c)

set_target_properties(matrix PROPERTIES PUBLIC_HEADER ./matrix.h)

# add the source files that are needed to build an exe
add_executable(gemm_test.out # our executable is the target
    gemm_test.f90
    matrix.f90)

pybind11_add_module(matrix
    mult_cpp.cpp)


# set output target
set_target_properties(matrix 
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "lib/"
    LIBRARY_OUTPUT_DIRECTORY "lib/"
    RUNTIME_OUTPUT_DIRECTORY "bin/"
)

# set link libraries for targets
target_link_libraries(gemm_test.out PRIVATE matrix)

# define header file path
target_include_directories(matrix PRIVATE .)

# set to use C11 features
target_compile_features(matrix PRIVATE c_std_11)

# set compiler options
target_compile_options(matrix PRIVATE -Wall -O3)
