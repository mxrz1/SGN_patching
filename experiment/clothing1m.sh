# !usr/bin/bash

PWD=$(pwd)
DSET=clothing1m
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

TEST_NAME=clothing1m

if [ ! -f $CACHE_DIR/$TEST_NAME ]; then
	python src/clothing1m/sgn.py --data_dir=$DATA_DIR \
        	                --output_dir=$OUT_DIR \
				--download_data=True \
                        	--checkpoint_interval=$CP_INTERVAL

	if [ -z $? ]; then
		touch $CACHE_DIR/$TEST_NAME
	fi
else
	echo "TEST CACHE FOUND, SKIPPING"
fi

