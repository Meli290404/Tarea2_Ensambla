NASM = nasm
GCC  = gcc

NASMFLAGS = -f elf64
GCCFLAGS  = -no-pie

all: calcBiciesto

calcBiciesto: calcBiciesto.o
	$(GCC) $(GCCFLAGS) calcBiciesto.o -o calcBiciesto

calcBiciesto.o: calcBiciesto.asm
	$(NASM) $(NASMFLAGS) calcBiciesto.asm -o calcBiciesto.o

clean:
	rm -f calcBiciesto.o calcBiciesto

