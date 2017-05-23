	MODULE dealias
! (* 	------------------------------------------------------------ *)
! (* 	This MODULE contains the basic parameters for the simulation *)
! (* 	of the Shallow Water Equations via pseudospectral multidomain*)
! (* 	penalty method *)
! 
! (* 	Jorge Escobar-Vargas *)
! (* 	Cornell University *)
! (* 	February 2008 *)
! (* 	------------------------------------------------------------ *)
	USE scrotum
	implicit none
	save
	
! 	1. Number of collocation points for dealiasing
	integer, parameter :: m = 2*n
	
!	2. From nodal to modal
	real, dimension(n,n) :: Mn
	real, dimension(m,m) :: Mm

!	3. From modal to nodal
	real, dimension(n,n) :: Bn
	real, dimension(m,m) :: Bm
	
	END MODULE dealias
