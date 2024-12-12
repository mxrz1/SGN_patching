# !usr/bin/bash

PWD=$(pwd)
DSET=cifar10ls
CP_INTERVAL=10
EPOCHS=1
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

echo "============== NO NOISE ================"
TEST_NAME=no_noise

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
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


echo "============== SYM 20% ================"
echo
TEST_NAME=sym20

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type sym \
							--severity 0.2 \
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

echo "============== SYM 40% ================"
echo
TEST_NAME=sym40

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type sym \
							--severity 0.4 \
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

echo "============== SYM 60% ================"
echo
TEST_NAME=sym60

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type sym \
							--severity 0.6 \
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

echo "============== ASYM 20% ================"
echo
TEST_NAME=asym20

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type asym \
							--severity 0.2 \
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

echo "============== ASYM 30% ================"
echo
TEST_NAME=asym40

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type asym \
							--severity 0.3 \
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

echo "============== ASYM 40% ================"
echo
TEST_NAME=asym60

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/cifar/deterministic.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR/$TEST_NAME \
                	        --dataset cifar10 \
							--noisy_labels \
							--corruption_type asym \
							--severity 0.4 \
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

