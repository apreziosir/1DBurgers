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
	
! 	1. Maximum number of time steps
	integer, parameter :: tmax = 3

! 	2. Size of the time step
	real, parameter :: dT = 0.00005
	
! 	3. Courant Number
	real :: CN

! 	4. pasos
	integer, parameter :: pasos = int(tmax / dT) - 1

!       5. Vector with velocities for top BC APR *)
	real, dimension(pasos) :: crudas


	END MODULE aetas
