module matrix
    implicit none
    ! interface for c function

    type :: matrix_t
        real(kind=4), dimension(:,:), allocatable :: data
        integer :: rows, cols
    contains
        ! make sure to pass self
        procedure, pass :: init
    end type

    interface operator (*)
        module procedure fc_matmul
    end interface

    interface 
    subroutine my_matmul(n, c, a, b) bind(c, name="c_mat_mul")
        use, intrinsic :: iso_c_binding
        integer(kind=c_int), value :: n
        ! c_mat_mul takes matrices of c_float
        real(kind=c_float), dimension(*) :: c
        real(kind=c_float), dimension(*) :: a
        real(kind=c_float), dimension(*) :: b
    end subroutine
    end interface 

contains
    ! init subroutine allocates data (matrix) for self
    subroutine init(self, rows, cols)
      class(matrix_t), intent(out) :: self
        integer, intent(in) :: rows, cols
        real(kind=4), dimension(:,:), allocatable :: data
        allocate(data(rows, cols))
        self%data = data
        self%rows = rows
        self%cols = cols
    end subroutine init

    function fc_matmul(a, b) result(c)
        use, intrinsic :: iso_c_binding
        class (matrix_t), intent(in) :: a, b
        type (matrix_t):: c
        integer :: n
        n = A%rows
        call c%init(n, n)
        call my_matmul(n, transpose(c%data), transpose(a%data), transpose(b%data))
    end function fc_matmul
end module