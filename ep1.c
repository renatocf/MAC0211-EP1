# include <stdlib.h>
# include <stdio.h>

extern int selecionarmstrongs();

int main (int argc,char *argv[]){

char *entrada,*saida;
int n_arms;

if (argc < 3) {
    printf("Faltam parametros\n");
    exit(-1);
}

entrada = argv[1];
saida = argv[2];

n_arms = selecionarmstrongs(entrada, saida);

return 1;
}
