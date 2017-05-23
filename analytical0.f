	subroutine analytical(AS,t)
! 	*******************************************
! 	Analytical Solution for 1D Burgers equation
! 	via Hopf-Cole Transformation
! 
! 	The calculation of this solution fails for
! 	very small viscosity due to overflow
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	*******************************************
	
	USE scrotum
	USE map
	USE mound
	
	implicit none

	real,dimension(nsg),intent(out) :: AS
	real, intent(in) :: t
	
	real :: pi,s1,s2,f,p1,p2,h,eta,dh,I1,I2,nt
	real :: lval,mval
	
	integer :: i 
	
	pi=acos(-1.0)
	lval=-1000.
	mval= 1000.
	h=mval-lval
	dh=0.05
	nt = h/dh
	
	if (t == 0) then
	 
	 do i = 1, nsg
	  AS(i) = -sin(pi*cx(i))
	 enddo
	
	else
	
	do i = 1,nsg
	 s1=0.0
	 s2=0.0
! 	 Numerical Integration via Trapeziodal rule
	 do eta = lval,mval,dh
	  p1 = sin(pi*(cx(i)-eta))
	  f = exp(-cos(pi*(cx(i)-eta))/(2.0*pi*nu))
	  p2 = exp(-(eta**2.0)/(4.0*nu*t))
	  if (eta == lval) then
	   s1 = s1+(p1*f*p2)
	   s2 = s2+(f*p2)
	  else if (eta == mval) then
	   s1 = s1+(p1*f*p2)
	   s2 = s2+(f*p2)
	  else
	   s1 = s1+(2.0*p1*f*p2)
	   s2 = s2+(2.0*f*p2)
	  endif
	 enddo
! 	 write(*,*) i,p1,f,p2
	 I1=h*s1/(2.0*nt)
	 I2=h*s2/(2.0*nt)
	 AS(i)=-I1/I2
! 	 write(*,*) 'Carajo ',AS(i),I1,I2,s1,s2
! 	 stop
	enddo
	endif
	
	end subroutine analytical
