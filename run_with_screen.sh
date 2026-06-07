#!/bin/bash

# Script wrapper para executar run_experiments.sh dentro de um screen

SCREEN_SESSION="experimentos"

echo "Iniciando experimentos em background com screen..."
echo ""

# -d: cria detached (desanexado, roda em background)
# -m: cria sessão em modo mensagem
# -S: nome da sessão
screen -dmS $SCREEN_SESSION bash run_experiments.sh

echo "✓ Experimentos iniciados!"
echo "✓ Session: $SCREEN_SESSION"
echo ""
echo "Comandos úteis:"
echo "  screen -r $SCREEN_SESSION          # Anexar à sessão"
echo "  screen -ls                          # Listar sessões ativas"
echo "  screen -S $SCREEN_SESSION -X quit  # Encerrar sessão"
