	MODULE map
! 	------------------------------------------
! 	This module contains the variables for 
! 	the mapping from local to global coordinates

! 	Jorge Escobar-Vargas
! 	Cornell University
! 	February 2008
! 	------------------------------------------
	USE scrotum
	
	implicit none
	save
	
! 	1. Array with "x" physical coodinates
	real, allocatable, dimension(:) :: cx
	
	END MODULE map