#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

int primo (long int n) {
	int result = 1;
	#pragma omp parallel for shared(result) schedule(static, 10) num_threads(2)
	for (long int i = 3; i < (long int)(sqrt(n) + 1); i+=2){
	     if (n%i == 0) {
	     	result = 0;
         }
    }	         
	return result;
}

int main(int argc, char *argv[]) { /* primos_seq.c  */
double t_inicio, t_fim;
long int  n, total=0;

    omp_set_nested(1);
    omp_set_max_active_levels(2);

    if (argc < 2) {
        printf("Valor inválido! Entre com o valor do maior inteiro\n");
       	return 0;
    } else {
        n = strtol(argv[1], (char **) NULL, 10);
    }
        
    total++; /* Adiciona 2 que é primo */
    
    t_inicio = omp_get_wtime();
    
    // Debug: imprimir info de paralelismo
    #pragma omp parallel num_threads(2)
    {
        if (omp_get_thread_num() == 0) {
            printf("=== PARALELISMO DEBUG ===\n");
            printf("Threads disponíveis (omp_get_num_procs()): %d\n", omp_get_num_procs());
            printf("Max threads (omp_get_max_threads()): %d\n", omp_get_max_threads());
            printf("Threads no loop externo: %d\n", omp_get_num_threads());
            printf("Max active levels: %d\n", omp_get_max_active_levels());
            printf("======================\n\n");
        }
    }
    
    #pragma omp parallel for reduction(+:total) schedule(static, 10) num_threads(2)
        for (long int i = 3; i <= n; i += 2) {
            if(primo(i) == 1) total++;
        }
    
    t_fim = omp_get_wtime();
    printf("Quant. de primos entre 1 e %ld: %ld \n", n, total);
    printf("Tempo de execução: %3.10f\n", t_fim-t_inicio);
    
    return(0);
}
