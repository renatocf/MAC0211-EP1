#include<stdio.h>
#include<stdlib.h>

#include<getopt.h>

int main(int argc, char **argv)
{
    
    if(argv != 2) 
        printf("Erro: número incorreto de argumentos\n");
    
    printf("Hello World!");
    
    return 0;
}
