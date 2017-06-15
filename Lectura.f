	subroutine Lectura(mediavel)


	USE aetas
	USE geom


	implicit none

	integer :: i
	real,intent(out) :: mediavel
	
	open(55, file= 'Refinado100_10.dat', status='old')
	write(*,*) pasos
	do i = 1, pasos 
		read(55,*) crudas(i)
!		write(*,*) 'Velocidad en ', 'i', velocidades(i)	[prueba en pantalla]
	enddo
	close(55)
	
	mediavel = sum(crudas) / pasos
		   
	end subroutine Lectura
