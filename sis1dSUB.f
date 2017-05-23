	subroutine sis1dSUB(AG,delta)
	
! 	*******************************************************
! 	This subroutine assemble the global system of equations
! 	for 1D Solution of Helmholtz equation multidomain
! 	Note that also the transformation to the physical space
! 	is performed
	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	*******************************************************
	
	USE scrotum
	USE legendre
	USE geom
	
	implicit none
	
	real, dimension(nsg,nsg), intent(out) :: AG
	real, intent(in) :: delta
	integer :: row, col
	real :: lx
	integer :: i,j,k
	
	AG = 0.
	
	do k=0,numsub-1
	  lx = abs(cgp(k+1) - cgp(k+2))
	  do i=1,n
	    do j=1,n
	      row = (k*n) + i
	      col = (k*n) + j
	      AG(row,col) = delta * d2(i,j) * (2./lx)**2.
	    enddo
	  enddo
        enddo
	
	do i=1,nsg
	  AG(i,i) = AG(i,i) - 1.0
	enddo
	
	end subroutine sis1dSUB