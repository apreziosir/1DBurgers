	subroutine mapping
! 	--------------------------------------------------------------
! 	This subroutine mapp the gllp into the physical space
! 	Modification for the 1D Burgers equation
! 	Jorge Escobar - Cornell University
! 	LAST REVISION 07/23/08
! 	--------------------------------------------------------------
! 	MODULES
	USE scrotum
	USE geom
	USE legendre
	USE map
	
! 	LIST OF VARIABLES -> See modules
	
	implicit none

! 	Local Variables
	integer :: c2,i,j
	real :: lx1,lx2

! 	Setting GLL points for each subdomain (YO PUSE EL 0 APR!!!!)
	do i = 0,nsg-1,n
	 do j = 1,n
	  cx(i+j) = points(j)
	 enddo
	enddo

!   Sets the points for each point of each subdomain (APR)	
	do i = 1,numsub 
	 lx1 = cgp(i)
	 lx2 = cgp(i+1)
	 do j =  1,n
	  c2 = n*(i-1) + j
	  cx(c2)= ((lx2-lx1) * (cx(c2)+1)/2) + lx1
	 enddo
	enddo
	
!	Verificando los puntos en todo el dominio (APR)	Escribo por si acaso
	open(12,file='All_Points.dat')
	write(12,*)"# PONT'S COORDINATES"
	write(12,*)'# NUMBER OF POINTS IN DOMAIN = ', nsg
	write(12,*)''
	do i = 1, nsg
		write(12,*) cx(i)
	enddo
	
	close(12)
	
	end subroutine mapping
