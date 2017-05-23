	subroutine diffx(rho,dx)
! 	-----------------------------------------------
! 	This subroutine calculates the X - derivatives
! 	for the skew-symmetric advective term of the 
! 	1D Burgers equation

! 	Jorge Escobar-Vargas
! 	Cornell University
! 	July - 2008
! 	-----------------------------------------------
! 	MODULES
	USE scrotum
	USE geom
	USE legendre

	implicit none
! 	Dummy Variables
	real, dimension(nsg), intent(in) :: rho
	real, dimension(nsg), intent(out) :: dx
! 	Local Variables
	real, dimension(n) :: R
	integer :: p, i, k
	real :: lx
	
	do k = 0,numsub-1
	 lx = abs(cgp(k+1) - cgp(k+2))
	  do i = 1,n
	   p = (k*n) + i
	   R(i) = rho(p)
	  enddo
	  R = matmul(d,R)
	  R = R * (2.0 / lx)
	  do i = 1,n
	   p = (k*n) + i
	   dx(p) = R(i)
	  enddo
	enddo
	
	end subroutine diffx