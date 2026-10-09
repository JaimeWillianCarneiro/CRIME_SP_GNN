#!/bin/bash

# Define o caminho absoluto para evitar quebra de diretórios
BASE_PATH=$(realpath "src/dataloader/data/processed/sp")

for config_folder in "$BASE_PATH"/celulares_r*/ ; do
    # Se o bash não encontrar as pastas, ele pula a execução em vez de tentar ler o asterisco
    [ -e "$config_folder" ] || continue
    
    echo "========================================================="
    echo "1. Formatando tensores: $config_folder"
    echo "========================================================="
    
    cd src/dataloader/
    python3 egcn_dataloader.py --time_delta M --data_path "$config_folder"
    cd ../../
    
    echo "========================================================="
    echo "2. Treinando o modelo EGCN_H na partição"
    echo "========================================================="
    
    cd src/EGCN_model/
    python3 run_sp_exp.py --config_file ./experiments/parameters_sp_egcn_h.yaml
    cd ../../
done