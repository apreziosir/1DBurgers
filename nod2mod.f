	subroutine nod2mod(wg)

	USE scrotum
	USE legendre
	USE dealias

	implicit none

	real,dimension(n),intent(in) :: wg

	real, dimension(n,n) :: Cn,Wn
	real, dimension(n) :: Pn
	real, dimension(m,m) :: Cm,Wm
	real, dimension(m) :: Pm

	integer :: j,i,k,kp,km

	real,allocatable,dimension(:) :: wgM,pointsM


!	1) Obtaining matrix "Mn" -> Umodal = Mn * Unodal
	do j=1,n
	 Pn(1)=1.
	 Pn(2)=points(j)
	 do k=2,n-1
	  kp=k+1
	  km=k-1
	  Pn(kp)=(((2.0*(k-1))+1.)*Pn(2)*Pn(k)/k)-((k-1)*Pn(km)/k)
	 enddo
	 do i=1,n
	  Bn(j,i)=Pn(i)
	 enddo
	enddo
	Cn=0.0
	Wn=0.0
	do i=1,n-1
	 Cn(i,i)=(i-1.)+0.5
	 Wn(i,i)=wg(i)
	enddo
	Cn(n,n)=n/2.
	Wn(n,n)=wg(n)
	Mn=matmul(Cn,transpose(Bn))
	Mn=matmul(Mn,Wn)

!	2) Obtaining the new set of points "m"
	allocate(pointsM(m),wgM(m))
	call jacobl(m-1,0.,0.,pointsM,m)
	call quad(m-1,pointsM,wgM,m-1)

	do j=1,m
	 Pm(1)=1.
	 Pm(2)=pointsM(j)
	 do k=2,m-1
	  kp=k+1
	  km=k-1
	  Pm(kp)=(((2.0*(k-1))+1.)*Pm(2)*Pm(k)/k)-((k-1)*Pm(km)/k)
	 enddo
	 do i=1,m
	  Bm(j,i)=Pm(i)
	 enddo
	enddo
	Cm=0.0
	Wm=0.0
	do i=1,m-1
	 Cm(i,i)=(i-1.)+0.5
	 Wm(i,i)=wgM(i)
	enddo
	Cm(m,m)=m/2.
	Wm(m,m)=wgM(m)
	Mm=matmul(Cm,transpose(Bm))
	Mm=matmul(Mm,Wm)

	deallocate(pointsM,wgM)

	end subroutine nod2mod
