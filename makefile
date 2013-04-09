armstrong: seleciona_armstrong.o armstrong.o 
	gcc -o $@ $^

seleciona_armstrong.o: seleciona_armstrong.asm
	nasm -f elf32 $<

armstrong.o: armstrong.c
	gcc -ansi -Wall -pedantic -c $<
