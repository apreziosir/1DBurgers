	program Burgers1D
! 	****************************************
! 	Solution of the 1D Burgers equation
! 	via Pseudo-spectral multidomain penalty
! 	methhod.
! 	
! 	Jorge Escobar-Vargas
! 	Cornell University - CEE
! 	July 2008
! 	****************************************
	USE scrotum
	USE mound
	USE geom
	USE legendre
	USE map
	USE aetas
	
	implicit none
	
	real, dimension(nsg) :: u
	real, dimension(nsg) :: BG
	real, dimension(nsg,nsg) :: AG
	real, dimension(n,n) :: F
	real, dimension(n) :: wg
	real, dimension(nsg) :: AS,err
	
	real,allocatable,dimension(:) :: dudx
	real,allocatable,dimension(:) :: stx,um1,um2,stxm1,stxm2
	
	integer :: i,t, niter,ll,ff,pp
	real :: delta,cou,Linf,mediavel, filter
	
!	Defining value of filter for simulation (should proportional to time 
!	gap used)	
	filter = 3. !1.57
	
	open(10,file='Results.dat')
	write(10,*)'# VELOCITY PROFILES IN TIME'
	write(10,*)''
	write(10,*)'# TOTAL POINTS IN GRID = ', nsg
	write(10,*)'# VARIABLES = z, u(z)'
	write(10,*)'# TOTAL TIME SIMULATED (s) = ', tmax
	write(10,*)'# APPARENT VISCOSITY USED = ', nu
!	dT = (tmax*1.0) / (pasos*1.0)
	write(10,*)'# TIME GAP (s) = ', dT
	write(10,*)'# VALUE OF FILTER USED FOR SIMULATION = ', filter
	write(10,*)''
	write(10,*)''
	
! 	Reading geometry file (modificado para no escribir y leer los .dat)
	call geometry
	
!	Leer vector de velocidades (APR)
	call Lectura(mediavel)
!	write(*,*) 'Velocidad media =', mediavel

!	Refinar vector de velocidades de acuerdo con el dx seleccionado 
	
	
! 	Generate array with collocation points
	allocate(points(n))
	call jacobl(pd,0.,0.,points,n)

! 	Generate differentiation matrices
	allocate(d(n,n),d2(n,n),d3(n,n))
	call derv(pd,points,d,d2,d3,pd)
	
! 	Generate Weights for Legendre polynomials and filter matrix
	call quad(pd,points,wg,pd)
	call localFil(n,points,F,wg,filter)
!	Setting dealiasing matrices
	call nod2mod(wg)
	
! 	Mapping
	allocate(cx(nsg))
	call mapping
	
! 	Generating initial condition
!	write(*,*) 'todo bien11'
	call analytical(u,mediavel)
!	write(*,*) 'todo bien'
	write(10,*) "# VELOCITY'S INITIAL CONDITION - CONSTANT"
	write(10,*)''
	do i = 1,nsg
	 write(10,*) cx(i),u(i)
	enddo
	write (10,*) ''
	
! 	Setting dT and tmax
	call time(u)
		
!	Refining velocities
	call Refining
		
! 	Loop over time
	allocate(um1(nsg),um2(nsg),stxm1(nsg),stxm2(nsg))
	
	AS=0.
!	err=0.
! 	pp = 100
	pp = (tmax / dT) ! Aqui habia un  -1
	ll = (pp/(20))
	ff = 1.0
	
!	write(*,*) 'hasta aca', dT, pp

!	============================================================================
!	ESTE ES EL BUCLE TEMPORAL DEL PROGRAMA!	
!	============================================================================

	do t = 1,pp
		call CFL(u, cou)
		if (mod(t,100) == 0) then
			write (*,*) 'CALCULATED CFL FOR TIME (s)', t*dT, cou
		endif	
!		CN = abs((dT * maxval(u)) / (abs(cx(2) - cx(1))))
!		write(*,*) 'Velocidad maxima = ', maxval(u)
!		write(*,*) 'El CFL es = ', CN	
! 	 Setting advective part
	 allocate(dudx(nsg))
	 call diffx(u,dudx)
	 
	 allocate(stx(nsg))
	 call spamer(u,dudx,stx)
	 
! 	 !! NO PENALIZED BC FOR THIS TEST CASE BECAUSE u = 0 
! 	    at physical boundaries!!
	 
! 	 Setting the penalized patching conditions
	 call patchpen(u,u,stx)
	 
! 	 Advancing in time
	 call BDAB(t,u,stx,um1,um2,stxm1,stxm2)
!	 Filtro de parte advectiva (generalmente no se debe quitar)
	 call filtering(u,F)
	 
	 deallocate(stx)
	 deallocate(dudx)
	 
! 	 Setting the diffusive part (Helmholtz)
	 call setdelta(t,u,BG,delta)
	 
! 	 Generating the global matrix
	 call sis1dSUB(AG,delta)
	 
! 	 Imposing Boundary and Patching conditions
	 call bc1dSUB(AG,BG,delta,t)
	 
! 	 Solving the system of equations
	 call solve_gmres(u,BG,AG,nsg,niter)
!	 Filtro de parte temporal (se puede quitar o poner de acuerdo con necesidad)
	 call filtering(u,F)
	 
	 call CFL(u,cou)
!	 write(*,*) t, pp, dT, niter, cou, nu
	 
!	 if (t == ll*ff) then
	  ff = ff + 1
! 	  Calculating analytical solution
!	  if ( ff-1 == pp/ll) then
!	   call analytical(AS,dT*t)
! 	  endif
!	  err = AS - u 
	  if (mod(t,100) == 0) then         ! Poner en real el comparativo
		  write(10,*) '# VELOCITY PROFILE IN t = ', t*dT
		  write(10,*)''
		  do i = 1,nsg
		  	 write(10,*) cx(i), u(i)
		  enddo
		  write(10,*) ''
	  endif
!	  err = abs(err)
!	  Linf = maxval(err)
!	  write(*,*)'In the time step', t,'. Linf = ', Linf
! 	  stop
!	  endif
!	 endif
	
	enddo
	
	deallocate(velocidades)
	deallocate(points)
	deallocate(d,d2,d3)
	deallocate(cx)
	deallocate(um1,um2,stxm1,stxm2)
	
	close(10)
	
	end program Burgers1D
