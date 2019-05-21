PROG =	parflowslopes

SRCS =	main.f slopes.f writepfb.f 

OBJS =	main.o slopes.o writepfb.o 

FC = gfortran
FFLAGS = -Wall -fimplicit-none -pedantic -fcheck=all -g -fdump-core -fbacktrace -ffpe-trap=invalid,overflow,underflow,zero 

all: $(PROG)

$(PROG): $(OBJS)
	$(FC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS)
distclean:
	rm -f $(PROG) $(OBJS)
