CC = gcc
CFLAGS = -ansi -Wall -pedantic

NASM = nasm
NASMFLAGS = -f elf32

RM = rm -f

armstrong: seleciona_armstrong.o armstrong.o 
	$(CC) -o $@ $^

seleciona_armstrong.o: seleciona_armstrong.asm
	$(NASM) $(NASMFLAGS) $<

armstrong.o: armstrong.c
	$(CC) $(CFLAGS) -c $<

clean:
	$(RM) *.o
