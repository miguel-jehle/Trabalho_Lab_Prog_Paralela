#!/bin/bash

# Script para compilar e executar todos os experimentos

OUTPUT_FILE="resultados_$(date +%Y%m%d_%H%M%S).txt"

echo "========================================" | tee $OUTPUT_FILE
echo "EXPERIMENTOS DE CONTAGEM DE PRIMOS" | tee -a $OUTPUT_FILE
echo "OMP_NUM_THREADS=4" | tee -a $OUTPUT_FILE
echo "Data: $(date)" | tee -a $OUTPUT_FILE
echo "========================================" | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# Número limite para teste (500 milhões conforme especificação do trabalho)
LIMIT=500000000

# Compilar todos os programas
echo "Compilando..." | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

gcc-15 -fopenmp -o sequencial sequencial.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o naive_static naive_static.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o naive_dynamic naive_dynamic.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o naive_guided naive_guided.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o BOT_static BOT_static.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o BOT_dynamic BOT_dynamic.c 2>&1 | tee -a $OUTPUT_FILE
gcc-15 -fopenmp -o BOT_guided BOT_guided.c 2>&1 | tee -a $OUTPUT_FILE

echo "" | tee -a $OUTPUT_FILE
echo "========================================" | tee -a $OUTPUT_FILE
echo "EXECUTANDO EXPERIMENTOS (limite: $LIMIT)" | tee -a $OUTPUT_FILE
echo "========================================" | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# Naive Static
echo ">>> NAIVE STATIC <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./naive_static $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# Naive Dynamic
echo ">>> NAIVE DYNAMIC <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./naive_dynamic $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# Naive Guided
echo ">>> NAIVE GUIDED <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./naive_guided $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# BOT Static
echo ">>> BOT STATIC <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./BOT_static $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# BOT Dynamic
echo ">>> BOT DYNAMIC <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./BOT_dynamic $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# BOT Guided
echo ">>> BOT GUIDED <<<" | tee -a $OUTPUT_FILE
OMP_NUM_THREADS=4 ./BOT_guided $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

# Sequencial (executado por último)
echo ">>> SEQUENCIAL <<<" | tee -a $OUTPUT_FILE
./sequencial $LIMIT 2>&1 | tee -a $OUTPUT_FILE
echo "" | tee -a $OUTPUT_FILE

echo "========================================" | tee -a $OUTPUT_FILE
echo "Resultados salvos em: $OUTPUT_FILE" | tee -a $OUTPUT_FILE
echo "========================================" | tee -a $OUTPUT_FILE
