	MODULE geom
! (* 	----------------------------------------- *)
! (* 	This module contains the geometric information *)
! (* 	for the simulation. *)
! 
! (* 	Jorge Escobar-Vargas *)
! (* 	Cornell University *)
! (* 	February 2008 *)
! (* 	----------------------------------------- *)
	USE scrotum
	USE aetas
	implicit none
	save
	
! (* 	1. Array with coordinates of grid points *)
	real, dimension(ngp) :: cgp
	
! (* 	2. Array with subdomain corner (nodal) points *)
! 	integer, dimension(numsub,4) :: scp
	
! (* 	3. Array with type of Boundary condition  *)
	integer, dimension(2) :: cond
	
! (* 	4. Array with the value of BC at the physical boundaries *)
	real, dimension(2) :: val    
    	
! (*	5. Number of time steps for the program APR *)  
	integer, parameter :: pasos = 40000 ! = int(tmax / dT) - 1

! (*    6. Vector with velocities for top BC APR *)
	real, dimension(pasos) :: crudas
	
! (*	7. Vector de velocidades refinadas *)
	real, allocatable, dimension(:) :: velocidades
	
! (* 	7. Punto inicial en geometria)
	real, parameter :: x0 = 0.
	
! (*	8. Punto final en geometria)
	real, parameter :: xf = 1.0
	
  

	END MODULE geom
