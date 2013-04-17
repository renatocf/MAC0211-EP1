/******************************************************/
/**  MAC 0211  -  Introdução à  Computação           **/
/**  IME-USP   -  Primeiro  Semestre  de    2012     **/
/**  Turma 45  -  Kelly Rosa Bragheto                **/
/**                                                  **/
/**  Primeiro  Exercício-Programa                    **/
/**  Arquivo:  armstrong.c                           **/
/**                                                  **/
/**  Renato Cordeiro Ferreira            7990933     **/
/**  Diego Martos                        6880528     **/
/**                                                  **/
/**  10/04/13                                        **/
/******************************************************/ 

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>

int seleciona_armstrong(char *nome_arq_entrada, char *nome_arq_saida);

int main(int argc, char **argv)
{
    /** VARIÁVEIS *****************************************************/
        int debug = 1;         /* Opção para debug                   */
        int armstrongs;        /* Resultado de seleciona_armstrongs  */
        clock_t inicio, fim;   /* Variáveis para tempo de início/fim */
        double tempo_execucao; /* Tempo total de execução da função  */
    
    /** OPÇÕES ********************************************************/
        if(argc != 3) 
            printf("Erro: numero incorreto de argumentos\n");
        
    /** CALCULA ARMSTRONGS ********************************************/
        if(debug) inicio = clock();
        armstrongs = seleciona_armstrong(argv[1], argv[2]);
        if(debug) fim = clock();
    
    /** RESULTADOS ****************************************************/
        if(debug)
        {
            tempo_execucao = (double)(fim - inicio) / CLOCKS_PER_SEC;
            printf("A execucao da funcao levou %g segundos\n",
                    tempo_execucao);
        }
    
        printf("%d numero(s) de Armstrong encontrado(s)\n", armstrongs);
    
    return 0;
}
