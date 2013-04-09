#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>

int seleciona_armstrongs(char *nome_arq_entrada, char *nome_arq_saida);

int main(int argc, char **argv)
{
    /** VARIÁVEIS *****************************************************/
        int debug = 0;         /* Opção para debug                   */
        int armstrongs;        /* Resultado de seleciona_armstrongs  */
        clock_t inicio, fim;   /* Variáveis para tempo de início/fim */
        double tempo_execucao; /* Tempo total de execução da função  */
    
    /** OPÇÕES ********************************************************/
        if(argc != 3) 
            printf("Erro: numero incorreto de argumentos\n");
        
    /** CALCULA ARMSTRONGS ********************************************/
        if(debug) inicio = clock();
        armstrongs = seleciona_armstrongs(argv[1], argv[2]);
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

int seleciona_armstrongs(char *nome_arq_entrada, char *nome_arq_saida)
{
    /** VARIÁVEIS *****************************************************/
        int aux = 0;          /* Salva cópia do número para modificar*/
        int candidato;        /* Número original lido da entrada     */
        int unidade = 0;      /* Parte do número a ser analisada     */
        int tamanho = 1;      /* Tamanho contado do número atual     */
        double soma = 0;      /* Soma das potências das unidades     */
        int armstrongs = 0;   /* Total de números de armstrong       */
        FILE *input, *output; /* Streams para arquivos de E/S        */
    
    /** ABERTURA DOS ARQUIVOS *****************************************/
        input = fopen(nome_arq_entrada, "r");
        output = fopen(nome_arq_saida, "w");
    
    /** LEITURA DOS NÚMEROS *******************************************/
        while(fscanf(input, "%d", &candidato) != EOF)
        {
            soma = 0; /* Soma para o candidato atual */
            
            /* Conta tamanho do número candidato */
            for(aux = candidato, tamanho = 1; 
                aux/10 != 0; tamanho++, aux /= 10);
                
            /* Calcula potência baseado na quantidade */
            for(aux = candidato; aux != 0; aux /= 10)
            {
                unidade = aux % 10;
                soma += pow(unidade, tamanho);
            }
            
            /* Imprime na saída se o número for de armstrong */
            if(soma == candidato) 
            { 
                fprintf(output, "%d ", candidato);
                armstrongs++;
            }
        }
    
    /** FECHAMENTO DOS ARQUIVOS ***************************************/
        fclose(output); output = NULL;
        fclose(input); input = NULL;
    
    return armstrongs;
}
