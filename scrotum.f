	MODULE scrotum
! (* 	------------------------------------------------------------ *)
! (* 	This MODULE contains the basic parameters for the simulation *)
! (* 	of the Shallow Water Equations via pseudospectral multidomain*)
! (* 	penalty method *)
! 
! (* 	Jorge Escobar-Vargas *)
! (* 	Cornell University *)
! (* 	February 2008 *)
! (* 	------------------------------------------------------------ *)
	implicit none
	save
	
! (* 	1. Number of collocation points in each direction per subdomain *)
	integer, parameter :: n = 16
	
! (* 	2. Number of subdomains  *)
	integer, parameter :: numsub = 6
	
! (* 	3. Number of grid points *)
	integer, parameter :: ngp = numsub + 1
	
! (* 	4. Global number of collocation points (nsg=ns*numsub)  *)
	integer, parameter :: nsg = n * numsub
	
! (* 	5. Polynomial degree *)
	integer, parameter :: pd = n - 1
	

	
	END MODULE scrotum
