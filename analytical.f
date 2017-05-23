	subroutine analytical(AS,mediavel)
! 	*******************************************
! 	Analytical Solution for 1D Burgers equation
! 	via Hopf-Cole Transformation
! 
! 	The calculation of this solution fails for
! 	very small viscosity due to overflow
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	*******************************************
	
	USE scrotum
	USE geom
	
	implicit none

	real,dimension(nsg),intent(out) :: AS
	real, intent(in) :: mediavel
	integer :: i
	
	do i = 0,nsg
		AS(i) = mediavel
!		write(*,*) AS(i)
	enddo
		
	end subroutine analytical
