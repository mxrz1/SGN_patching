# !usr/bin/bash

PWD=$(pwd)
DSET=webvision
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

echo "============== RUNNING $DSET TESTS ================"
echo

echo "============== NO NOISE ================"
TEST_NAME=webvision

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python3.8 src/cifar/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
                	        --dataset webvision \
				--download_data=True \
                        	--checkpoint_interval=$CP_INTERVAL

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

