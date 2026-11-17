#!/bin/bash

run_commands(){
    eval template="$1"
    for train_frac in 0.5 0.4 0.3 0.2 0.1; do
        for ((i=1; i<=10; i++)); do
            run_param="${i}o10"
            eval "$1 --run $run_param --train_frac $train_frac"
        done
    done
}

cd src/

# Strats mimic_iii
python main.py --pretrain 1 --dataset mimic_iii --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-4 --max_epochs 30
template="python main.py --dataset mimic_iii --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-5 --load_ckpt_path ../outputs/mimic_iii/pretrain/checkpoint_best.bin"
run_commands "\${template}"

# Strats physionet
python main.py --pretrain 1 --dataset physionet_2012 --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-4 --max_epochs 100
template="python main.py --dataset physionet_2012 --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-5 --load_ckpt_path ../outputs/physionet_2012/pretrain/checkpoint_best.bin"
run_commands "\${template}"

# Strats (ss-) mimic_iii
template="python main.py --dataset mimic_iii --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-4"
run_commands "\${template}"

# Strats (ss-) physionet
template="python main.py --dataset physionet_2012 --model_type strats --hid_dim 64 --num_layers 2 --num_heads 16 --dropout 0.2 --attention_dropout 0.2 --lr 5e-4"
run_commands "\${template}"



