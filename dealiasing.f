	subroutine dealiasing(a,b,ab)
!	************************************************
!	Dealiasing subroutine for quadratic nonlinearity
!	Based on the explanation given on page 137 of
!	SPECTRAL METHODS: Fundamentals in Single Domains
!	Canuto et.al. 2006
!
!	Jorge Escobar-Vargas
!	Cornell University - CEE
!	August 2011
!	************************************************

	USE scrotum
	USE dealias

	implicit none

	real,dimension(nsg),intent(in) :: a,b
	real,dimension(nsg),intent(out) :: ab

	real,allocatable,dimension(:) :: umod_m,vmod_m,uvm,u,v,uv
	real,allocatable,dimension(:) :: uvmod_m,uvmod_n,um,vm

	integer :: i,k,ti,ts

	ab = 0.

!	Loop over the subdomains
	do k = 1,numsub

	  ti = n*(k-1) + 1
	  ts = k*n

	  allocate(u(n),v(n))
	  u = a(ti:ts)
	  v = b(ti:ts)

!	  Obtaining MODAL coefficients

	  allocate(umod_m(m),vmod_m(m))
	  umod_m = 0.
	  vmod_m = 0.

	  umod_m(1:n) = matmul(Mn,u)
	  vmod_m(1:n) = matmul(Mn,v)

! 	  Obtaining NODAL values on extended grid

	  allocate(um(m),vm(m))
	  um = matmul(Bm,umod_m)
	  vm = matmul(Bm,vmod_m)

!	  Multiplying extended vectors
	 
	  allocate(uvm(m))
	  do i = 1,m
	    uvm(i) = um(i) * vm(i)
	  enddo

! 	  Obtaining MODAL values of product "ab"

	  allocate(uvmod_m(m))
	  uvmod_m = matmul(Mm,uvm)

!	  Eliminating additional MODES from "abmod"

	  allocate(uvmod_n(n))
	  uvmod_n = uvmod_m(1:n)

!	  Back to NODAL and final result

	  allocate(uv(n))
	  uv = matmul(Bn,uvmod_n)

	  ab(ti:ts) = uv

	  deallocate(umod_m,vmod_m,uvmod_m,uvmod_n,uvm,um,vm,u,v,uv)
	  
	enddo

	end subroutine dealiasing
