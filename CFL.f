	subroutine CFL(u,cou)
! 	******************************
! 	Calculation of CFL number for
! 	1D Burgers equation
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University
! 	July 2008
! 	******************************
	
	USE scrotum
	USE aetas
	USE map
	
	implicit none
	
	real, intent(out) :: cou
	real, dimension(nsg), intent(in) :: u
	
	real :: vel1,vel2,vel,dx
	
	vel1 = maxval(u)
	vel2 = minval(u)
	vel = max(vel1,abs(vel2))
	
	dx = abs(cx(2) - cx(1))
	
	cou = dT * vel / dx
!	write(*,*) 'El CFL calculado es', cou
	end subroutine CFL
