	MODULE mound
! 	----------------------------------
! 	This module containd the physical
! 	parameters of the simulation
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	February 2008
! 	----------------------------------
	implicit none
	save
	
! 	1. Viscosity
	real, parameter :: nu = 0.05 

!	2. Fac en bc1dsub
	real, parameter :: fac = 1e10

!       3. Filter del metodo en main
	real, parameter :: filter = 8.
	
	END MODULE mound
