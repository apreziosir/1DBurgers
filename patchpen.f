	subroutine patchpen(u,rho,st)
! 	-------------------------------------------------
! 	This subroutine imposes patching conditions to the
! 	Advective terms of the 1D Burgers equation

! 	Jorge Escobar-Vargas 
! 	Cornell University
! 	July 2008

! 	LIST OF LOCAL VARIABLES
! 	taul -> Tau coefficient of left subdomain
! 	taur -> Tau coefficient of right subdomain
! 	lx -> Length of the left subdomain of the interface
! 	lx1 -> Length of the right subdomain of the interface
! 	mfl -> Mapping factor for LEFT subdomain
! 	mfr -> Mapping factor for RIGHT subdomain
! 	-------------------------------------------------

! 	MODULES
	USE scrotum
	USE geom
	
	implicit none
	
! 	Dummy Variables
	real,dimension(nsg),intent(in) :: rho,u
	real,dimension(nsg),intent(inout) :: st
! 	Local variables
	integer :: j,r1,r2
	real :: lx, lx1, mfl, mfr
	real :: alpha, gamma, omega
	real :: taul,taur,fac
	
! 	Some parameters
	fac = 0.5 !1.0
	omega = 2.0 / (pd * (pd + 1.0))

!  	Patching at the interfaces

	if (numsub /= 1) then
	do j = 1,numsub-1
	 lx = abs(cgp(j) - cgp(j+1))
	 mfl =  2.0 / lx
	 lx1 = abs(cgp(j+1) - cgp(j+2))
	 mfr =  2.0 / lx1
	 r1 = j * n ! Left Subd
	 r2 = (j * n) + 1 ! Right Subd
	 
	 if (u(r1) >= 0.0) then ! Apply penalty to Right side of the interface
	  
	  alpha = u(r1)
	  taur = fac * mfr / (2.0*omega)
	  st(r2) = st(r2) + (taur * ((alpha*rho(r2)) - (alpha*rho(r1))))
	 
	 else ! Apply penalty to LEFT side of the interface
	 
	  gamma = abs(u(r1))
	  taul = fac * mfl / (2.0*omega)
	  st(r1) = st(r1) + (taul * ((gamma*rho(r1)) - (gamma*rho(r2))))
	 
	 endif
	 
	enddo 
	endif
	 
	end subroutine patchpen
