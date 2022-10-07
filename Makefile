
all: gas

gas: switchCase.s
	as switchCase.s -o sw.o --gstabs+
	ld sw.o -o switchCase

clean:
	rm -f *.o switchCase
