#! /usr/bin/bash

source .venv/bin/activate

ROOT=$(pwd)

python3.8 ./src/cifar/sgn.py \
	--data_dir=$ROOT/data \
	--output_dir=$ROOT/out \
	--dataset cifar100 \
	--noisy_labels \
	--corruption_type sym \
	--severity 0.4

#deactivate
