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
	real, parameter :: nu = 0.02 !0.01 / 3.141592654

!	2. Fac en bc1dsub
	real, parameter :: fac = 0.5
	
	END MODULE mound
