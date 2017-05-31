	MODULE aetas
! 	-------------------------------------------------
! 	This module contains the information related with
! 	time steps
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University
! 	February 2008
! 	-------------------------------------------------
	implicit none
	save
	
! 	1. Size of the time step
	real :: dT
	
! 	2. Maximum number of time steps
	integer, parameter :: tmax = 2
	
! 	3. Courant Number
	real :: CN

	END MODULE aetas
