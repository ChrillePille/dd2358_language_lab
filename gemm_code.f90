module fort_matrix
  ! interface for c function
  interface
  subroutine matmul(n, c, a, b) bind(c, name="c_mat_mul")
    use, intrinsic :: iso_c_binding
    implicit none
    integer(kind=c_int), intent(in), value :: n
    ! c_mat_mul takes matrices of c_int
    integer(kind=c_int), dimension(n, n), intent(out) :: c
    integer(kind=c_int), dimension(n, n), intent(in) :: a
    integer(kind=c_int), dimension(n, n), intent(in) :: b
  end subroutine
end interface
  type :: matrix_t
    integer, dimension(:,:), allocatable :: data
    integer :: rows, cols
  contains
    ! make sure to pass self
    procedure, pass :: init
  end type
contains
  ! init subroutine allocates data (matrix) for self
  subroutine init(self, rows, cols)
    class(matrix_t), intent(out) :: self
      integer, intent(in) :: rows, cols
      integer, dimension(:,:), allocatable :: data
      allocate(data(rows, cols))
      self%data = data
      self%rows = rows
      self%cols = cols
  end subroutine
end module



program gemm_test
  use fort_matrix
  implicit none 
  type(matrix_t) :: A, B, C
  ! Below is counter integers for placeholder matmul
  ! integer :: i, j, k
  ! integer :: s
  external c_mat_mul
  call A%init(10,10) 
  call B%init(10,10) 
  call C%init(10,10)

  ! Fill A, B with data
  A%data(1, 1:10) = 1d0
  A%data(2:4, 1:10) = 0d0
  A%data(4:10, 1:10) = 3d0
  B%data = 2d0
  C%data = 0d0 ! set C%data to all zeros
  !write(*,*) A%data ! show A%data
  !write(*,*) B%data ! show B%data
  !write(*,*) C%data ! show C%data

  ! C = A * B
  ! Placeholder matmul for part 1
  !do i = 1, 10, 1 !iterera över radindex
  !  do j = 1, 10, 1 !iterera över kolumnindex
  !    s = 0
  !    do k = 1, 10, 1
  !      s = s + A%data(k, i)*B%data(j, k)
  !    end do
  !    C%data(j, i) = s
  !  end do
  !end do

  !C = A * B
  
  
  ! Pass matrices (pointers) for C, A, and B
  call matmul(10, C%data, A%data, B%data)
  !write(*,*) C%data ! show C%data
  
  !We're done here, but we might want to deallocate?
  !deallocate(A%data)
  !deallocate(B%data)
  !deallocate(C%data)
end program gemm_test