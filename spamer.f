	subroutine spamer(u,dudx,stx)
! 	-------------------------------------------------------------
! 	This subroutine calculates the spatial term, which is used in
! 	the explicit scheme (AB) for Advection time advancement

! 	Jorge Escobar-Vargas 
! 	Cornell University
! 	February 2008
! 	-------------------------------------------------------------
! 	MODULES
	USE scrotum
	
	implicit none
! 	Dummy Variables
	real,dimension(nsg),intent(in) :: u
	real,dimension(nsg),intent(in) :: dudx
	real,dimension(nsg),intent(out) :: stx
! 	Local variables
	integer :: i,qq
	real :: advx
	real,allocatable,dimension(:) :: skewsym
	
	qq = 2
	
	if (qq == 1) then
	
! 	 Standard form
	 !do i = 1,nsg
	 ! stx(i) = u(i) * dudx(i)
	 !enddo
	 call dealiasing(u,dudx,stx)

	else
	
! 	 Skew-symmetric form
	 allocate(skewsym(nsg))
	 
	 do i=1,nsg
	  skewsym(i) = 0.5 * u(i) * u(i)
	 enddo
	 
	 call diffx(skewsym,stx) ! Here stx = 0.5 * duudx
	
	 do i=1,nsg
	
	  advx = 0.5 * (u(i)*dudx(i))
	  stx(i) = stx(i) + advx
	 
	 enddo

	 deallocate(skewsym)
	
	endif
	
	end subroutine spamer
