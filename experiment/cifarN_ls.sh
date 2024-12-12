#!/bin/bash

PWD=$(pwd)
DSET=cifarNls
CP_INTERVAL=100
EPOCHS=600
DATA_DIR=/home/baumana1/work/data/sgn_results/$DSET
OUT_DIR=/home/baumana1/work/data/sgn_results/out/$DSET
CACHE_DIR=/home/baumana1/work/data/sgn_results/.cache/$DSET

if [ ! -d $DATA_DIR ]; then
	mkdir -p $DATA_DIR
fi

if [ ! -d $OUT_DIR ]; then
	mkdir -p $OUT_DIR
fi

if [ ! -d $CACHE_DIR ]; then
	mkdir -p $CACHE_DIR
fi

2>&1
echo "============== RUNNING $DSET TESTS ================"
echo

echo "============== AGGREGATE ================"
TEST_NAME=aggre

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--corruption_type=aggre \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi


echo "============== RANDOM 1 ================"
echo
TEST_NAME=rand1

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--corruption_type rand1 \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== RANDOM 2 ================"
echo
TEST_NAME=rand2

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10  \
							--corruption_type rand2 \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data
	
	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== RANDOM 3 ================"
echo
TEST_NAME=rand3

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--corruption_type rand3 \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== WORST ================"
echo
TEST_NAME=worst

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--corruption_type worst \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== CIFAR-100N ================"
echo
TEST_NAME=cifar100

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python3 src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar100 \
							--corruption_type c100noise \
							--train_epochs=$EPOCHS \
                        	--checkpoint_interval=$CP_INTERVAL \
                        	--label_smoothing 0.001 \
							--download_data

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

