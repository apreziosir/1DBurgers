	subroutine Refining
	
!	============================================================================
!	Esta subrutina refina el perfil de velocidades de entrada de acuerdo con el 
!	dx mínimo para evitar problemas de estabilidad numerica al solucionar la 
!	ecuacion de Burgers 1D para atenuacion de velocidades en lechos de rios
!	Antonio Preziosi-Ribero Marzo de 2016 Universidad Nacional de Colombia
!	============================================================================

	use scrotum
	use geom
	use aetas
	
	implicit none

	integer :: tamanio
!	real :: 
	
	tamanio = int(dT * pasos / 0.005 )
	
	allocate(velocidades(pasos))
	
	velocidades = crudas	
	
	
	end subroutine Refining

	
