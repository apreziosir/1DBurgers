	subroutine time(u)
	
! 	***************************************
! 	This subroutine calculates the size and
! 	number of time-steps for 1D Burgers eqn
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	***************************************
	
	USE scrotum
	USE aetas
	USE map
	USE geom
	
	implicit none
	
	real,dimension(nsg),intent(in) :: u
	
	real :: vel,dx
	
	vel = maxval(abs(crudas))
	
	dx = abs(cx(2) - cx(1))

!	En este pedazo controlo el valor de dT para que quede fijo o no 
!	Debo arreglarlo cuando vaya a refinar. 	
!	dT = CN * dx / vel 
!	dT = ((tmax*1.0) / (pasos*1.0))

!	Calculo del numero de Courant con el dT fijo para que no se estalle	
	CN = (vel * dT) / dx
	
!	write(*,*)'u1 = ', u(1)
!	write(*,*)'u2 = ', u(2) 
	write(*,*)'u maximo es = ', vel
	write(*,*)'dx es = ', dx
	write(*,*)'delta tiempo es = ', dT
	write(*,*)'Courant inicial calculado = ', CN
	
!	pause 
	
!	tmax se debe variar dependiendo del input de velocidades en contorno	
!	tmax = 2.0 / (3.141592654 * dt)
!    tmax = 10
!    tmax = 30  
!    tmax = 60 
	
	end subroutine time
