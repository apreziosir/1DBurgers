	subroutine bc1dSUB(AG,BG,delta,t)
	
! 	*******************************************
! 	1D solution helmholtz equation multidomain
! 	This subroutine impose bc (Dirichlet,Neumann)
! 	and also patching conditions in the interfaces between subdomains
! 	PENALTY IMPLEMENTATION
! 
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	*******************************************

	USE scrotum
	USE legendre
	USE geom
	
	implicit none
	
	real, dimension(nsg,nsg), intent(inout) :: AG
	real, dimension(nsg), intent(inout) :: BG
	real, intent(in) :: delta
	integer, intent(in) :: t
	
	real :: carayB,carayT,tauB,tauT,fac
	real :: alpha,beta,gamma,eps
	real :: kappaB,kappaT,omega,tau
	real :: lx,lxT,lxB
	
	integer :: i,k
	
! 	Penalty Coefficients
	alpha=1.0
	beta=1.0
	gamma=1.0
	eps=1.0
	omega=2.0/(pd*(pd+1.0))
	
! 	Bottom boundary condition (alpha,beta) (la de arriba en mi caso APR)
	if (cond(1) == 1) then ! Dirichlet
	
	  lx = abs(cgp(2) - cgp(1))
	  tau = (delta*(2./lx)**2.)/(alpha*omega**2.)
	  AG(1,1) = AG(1,1) - (tau*alpha)
!	  write(*,*) BG(1)
	  BG(1) = BG(1) - (tau*velocidades(t))
!	  write(*,*) t, 'valor de condicion', BG(1), velocidades(t)
	
	elseif (cond(1)==2) then ! Neumann
	
	  lx = abs(cgp(2) - cgp(1))
	  tau=(2.0/lx)/(beta*omega)
	  
	  do i=1,n
	    AG(1,i)=AG(1,i) + (tau*beta*delta*d(1,i)*(2./lx))
	  enddo
	  
	  BG(1)=BG(1)-(tau*val(1))
	
	else
	  
	  write(*,*) 'Something wrong in the bottom boundary conditions'
	
	endif
	
! 	Top boundary conditions (gamma,eps)
	if (cond(2) == 1) then ! Dirichlet
	
	  lx = abs(cgp(numsub+1) - cgp(numsub))
	  tau = (delta*(2./lx)**2.)/(gamma*omega**2.)
	  AG(nsg,nsg) = AG(nsg,nsg) - (tau*gamma)
	  BG(nsg) = BG(nsg) - (tau*val(2))
	  
	elseif (cond(2) == 2) then ! Neumann
	
	  lx = abs(cgp(numsub+1) - cgp(numsub))
	  tau=(2.0/lx) / (eps*omega)
	  
	  do i=1,n
	    AG(nsg,nsg-n+i) = AG(nsg,nsg-n+i) - 
     >	               (tau*eps*delta*d(n,i)*(2./lx))
	  enddo
	  
	  BG(nsg)=BG(nsg)-(tau*val(2))
	  
	else
	
	  write(*,*) 'Something wrong in the top boundary conditions'
	
	endif	
	
! 	Patching conditions
! 	These conditions should be viewed from the interface point of view
! 	This case is implemented with the same syntax that Diamessis 2005 JCP
! 	tauB -> Coefficient for the lower subdomain (bottom of the interface)
! 	tauT -> Coefficient for the upper subdomain (top of the interface)

	fac=1e5!7.9e8
! 	For bottom subdomains
	kappaB=omega*alpha/beta
	carayB=1.0/(omega*eps*beta)
	
! 	For top subdomains
	kappaT=omega*gamma/eps
	carayT=1.0/(omega*eps*beta)
	
!       Continuity in the function "u"
	do k=1,numsub-1
	  
	  lxB = abs(cgp(k+1)-cgp(k))
	  lxT = abs(cgp(k+1)-cgp(k+2))
	  
	  tauB = carayB*(delta+(2.0*kappaB) - (2.0*sqrt(kappaB**2.0+
     >	       (delta*kappaB))))*(2.0/lxB)
     
	  tauT = carayT*(delta+(2.0*kappaT) - (2.0*sqrt(kappaT**2.0+
     >	       (delta*kappaT))))*(2.0/lxT)
          
! 	  Diagonal component of bottom of the interface
	  AG((k*n),(k*n)) = AG((k*n),(k*n)) - (fac*tauB*alpha)
	  
! 	  Contribution from top part of the interface to the bottom one
	  AG((k*n),(k*n)+1) = AG((k*n),(k*n)+1) + (fac*tauB*gamma)
	  
! 	  Diagonal component of top part of the interface
	  AG((k*n)+1,(k*n)+1) = AG((k*n)+1,(k*n)+1) - (fac*tauT*gamma)
	  
! 	  Contribution from bottom point of the interface to the top one
	  AG((k*n)+1,(k*n)) = AG((k*n)+1,(k*n)) + (fac*tauT*alpha)
	  
! 	Continuity in the derivative
	  do i=1,n
	  
! 	    Bottom point of the interface
	    AG((k*n),((k-1)*n)+i) = AG((k*n),((k-1)*n)+i) - 
     >	    (fac*tauB*beta*delta*d(n,i)*(2./lxB))
     
! 	    Contribution from top to bottom
	    AG((k*n),(k*n)+i) = AG((k*n),(k*n)+i) + 
     >	    (fac*tauB*eps*delta*d(1,i)*(2./lxT))
     
! 	    Contribution from bottom to top
	    AG((k*n)+1,((k-1)*n)+i) = AG((k*n)+1,((k-1)*n)+i) - 
     >	    (fac*tauT*beta*delta*d(n,i)*(2./lxB))
     
! 	    Top point of the interface
	    AG((k*n)+1,(k*n)+i) = AG((k*n)+1,(k*n)+i) + 
     >	    (fac*tauT*eps*delta*d(1,i)*(2./lxT))
     
	  enddo
	enddo
	
	end subroutine bc1dSUB
