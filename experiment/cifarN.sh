# !usr/bin/bash

PWD=$(pwd)
DSET=cifarN
CP_INTERVAL=10
DATA_DIR=$PWD/data/$DSET
OUT_DIR=$PWD/out/$DSET
CACHE_DIR=$PWD/.cache/$DSET

SGN_DIR=$1

if [ ! -d $DATA_DIR ]; then
	mkdir $DATA_DIR
fi

if [ ! -d $OUT_DIR ]; then
	mkdir $OUT_DIR
fi

if [ ! -d $CACHE_DIR ]; then
	mkdir $CACHE_DIR
fi


cd $SGN_DIR
source .venv/bin/activate

2>&1
echo "============== RUNNING $DSET TESTS ================"
echo

echo "============== AGGREGATE ================"
TEST_NAME=aggre

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10_label_corrupted \
				--corruption_type=aggre \
                        	--checkpoint_interval=$CP_INTERVAL

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
	python src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10_label_corrupted \
				--corruption_type rand1 \
                        	--checkpoint_interval=$CP_INTERVAL

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
	python src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10_label_corrupted  \
				--corruption_type rand2 \
                        	--checkpoint_interval=$CP_INTERVAL
	
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
	python src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10_label_corrupted \
				--corruption_type rand3 \
                        	--checkpoint_interval=$CP_INTERVAL

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
	python src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10_label_corrupted \
				--corruption_type worst \
                        	--checkpoint_interval=$CP_INTERVAL

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== CIFAR-100 ================"
echo
TEST_NAME=cifar100

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python3.8 src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar100 \
				--corruption_type c100noise \
                        	--checkpoint_interval=$CP_INTERVAL

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

echo "============== CIFAR-100N ================"
echo
TEST_NAME=asym60

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python3.8 src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset cifar10 \
				--noisy_labels \
				--corruption_type asym \
				--severity 0.6 \
                        	--checkpoint_interval=$CP_INTERVAL

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

