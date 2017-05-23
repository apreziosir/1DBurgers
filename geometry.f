	subroutine geometry

!	============================================================================

!	Subrutina modificada para crear mallas no equiespaciadas para la solucion de 
!	la ecuacion de Burgers en 1D. La separacion sigue una regla de potencias de 
!	2 (1/2, 1/4, 1/8, 1/16, 1/32,...)
!	Antonio Preziosi-Ribero - Universidad Nacional de Colombia
!	marzo de 2016

!	============================================================================

! 	This program creates the input file for the solution of
! 	Helmholtz or Advection equation via Spectral Multidomain methods
! 	1D Equidistant Structured mesh
! 	Jorge Escobar - Cornell University
! 	July 2008

!	============================================================================

	USE scrotum
	USE geom
	
	implicit none
	
	real :: dx
	integer :: j, foo

! 	Subdomain Length
	foo = numsub - 1
	dx = (xf - x0) / (2 ** foo)
	
!	Abrir archivo para escribir coordenadas de subdominios
	open(75,file='Subdomains.dat')
	write(75,*)'# COORDINATES FOR EACH SUBDOMAIN'
	write(75,*)'# RESULTS PRESENTED IN METERS (m)'
	write(75,*)'# 0.0 IS THE SURFACE, Z AXIS IS POSITIVE DOWNWARDS'	
	write(75,*)''

! 	Creating coordinates of grid points
	do j=1,ngp
	  if (j /= 1) then 
	  	cgp(j) = x0 + dx * 2**(j - 2)
	  else	
	  	cgp(j) = x0
	  end if
	  write(*,*) cgp(j)
	  write(75,*) cgp(j)	
	enddo

! 	Type of boundary condition
	cond(1) = 1
	cond(2) = 2
	write(75,*) cond(1), cond(2)
!	Magnitude of imposed BC
	val(1) = 0
	val(2) = 0
 	write(75,*) int(val(1)), int(val(2))
 	close(75)	
 	
	end subroutine geometry
