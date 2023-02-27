module equation_syntax_tree
  implicit none
  private

  integer, parameter :: CHARACTER_MAX_LEN=400

  public :: test_split_string
contains
  recursive function split_string_recursive(string) result (s_out)
    implicit none
    character(len=CHARACTER_MAX_LEN), intent(in) :: string
    character(len=CHARACTER_MAX_LEN), pointer :: s_out(:)
    character(len=CHARACTER_MAX_LEN), pointer :: s_out_after(:)

    character(len=CHARACTER_MAX_LEN) :: before, after
    character(len=1) :: separator=','
    integer :: inx, s_out_after_size

    inx = index(string, separator)

    before = string(:inx-1)
    after = string(inx+1:)

    if (index(after,separator) .gt. 0) then
      s_out_after => split_string_recursive(after) 
      s_out_after_size = size(s_out_after)
      allocate(s_out(s_out_after_size+1))
      s_out(1) = before
      s_out(2:) = s_out_after(1:s_out_after_size)
    else
      allocate(s_out(2))
      s_out = (/ before, after /)
    end if

  end function split_string_recursive

  function split_string(string, separator) result (s_out)
    implicit none
    character(len=*), intent(in) :: string, separator
    character(len=CHARACTER_MAX_LEN), allocatable :: s_out(:)
    integer :: inx, dinx=1, i = 1, separator_size

    separator_size = len(separator)

    inx = index(string, separator)
    do while (dinx .gt. 0)
      i = i+1
      inx = inx + separator_size + index(string(inx:), separator) - 1
      dinx = index(string(inx:), separator)
    end do

    s_out = split_string_helper(string, separator, i)

  end function split_string

  function split_string_helper(string, separator, n) result (s_out)
    implicit none
    character(len=*), intent(in) :: string, separator
    integer, intent(in) :: n
    character(len=CHARACTER_MAX_LEN) :: s_out(n)
    integer :: inx, dinx=1, separator_size
    integer :: i

    separator_size = len(separator)

    inx = 1
    do i = 1, n
      dinx = inx
      inx = inx + separator_size + index(string(inx:), separator) - 1
      s_out(i) = string(dinx:inx-2)
    end do

    s_out(i-1) = string(inx:)
  end function split_string_helper


  subroutine test_split_string
    implicit none
    character(len=CHARACTER_MAX_LEN) :: string, string2
    character(len=CHARACTER_MAX_LEN), allocatable :: string_out(:)
    integer :: i

    string = "one,two,three,four,five,test"
    string2 = trim(string)//trim(string)//trim(string)// &
              trim(string)//trim(string)//trim(string)// &
              trim(string)//trim(string)//trim(string)// &
              trim(string)//trim(string)//trim(string)

    print *, len_trim(string2)

    do i = 1, 1000000
      string_out = split_string(string2, ',t')
    end do

    print *, string_out
  end subroutine test_split_string

end module equation_syntax_tree
