#  Output file name
   EXC = Toni.out
# 
# loading routines to compile. 
#  OPTIONS here.   
#

USE_INCL= scrotum.o aetas.o geom.o legendre.o map.o mound.o \
          dealias.o main.o geometry.o Lectura.o gll.o derv.o quad.o \
	      localFil.o erfc.o filtering.o mapping.o analytical.o \
	      time.o Refining.o diffx.o spamer.o patchpen.o BDAB.o \
	      setdelta.o sis1dSUB.o bc1dSUB.o solve_gmres.o \
	      lhs_gmres.o CFL.o nod2mod.o dealiasing.o
	      

FC = f95

FFLAGS = -O3 -fdefault-real-8


#  Compile

$(EXC): $(USE_INCL)
		$(FC) $(FFLAGS) $(USE_INCL) -o $@

$(USE_INCL):	$(INCLUDES)

.f.o:
		$(FC) $(FFLAGS) -c $*.f

clean:
		rm -f core $(EXC) $(USE_INCL) *.mod



     

