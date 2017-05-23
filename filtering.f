	subroutine filtering(U0,F)
	
! 	********************************
! 	1D exponential filter
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	********************************
	
	USE scrotum
	
	implicit none
	
	real, dimension(nsg), intent(inout) :: U0
	real, dimension(n,n), intent(in) :: F
	
	real, dimension(nsg) :: UN
	real, dimension(n) :: UT,UF
	integer :: i,j,left,right
	real :: ave
	
	UN=0.
	
	do i = 1,numsub
! 	 write(*,*)'Element: ',i
	 do j=1,n
	  UT(j) = U0(n*(i-1)+j)
	 enddo
! 	 write(*,*)(UT(k),k=1,n)
	 UF=matmul(F,UT)
! 	 write(*,*)(UF(k),k=1,n)
	 do j = 1,n
	  UN(n*(i-1)+j)=UN(n*(i-1)+j) + UF(j)
	 enddo
	 
	enddo
	
! 	Interfacial Averaging
	do i = 1,numsub-1
	 left = i * n
	 right = (i*n) + 1
	 ave = (UN(left-1) + UN(right+1)) / 2.
	 UN(left) = ave
	 UN(right) = ave
	enddo
	
	U0 = UN

	end subroutine filtering