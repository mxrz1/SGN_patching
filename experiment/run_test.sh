# !usr/bin/bash

PWD=$(pwd)
DATA_DIR=$PWD/data
OUT_DIR=$PWD/out
LOG_DIR=$PWD/log
CACHE_DIR=$PWD/.cache

if [ ! -d $DATA_DIR ]; then
	mkdir $DATA_DIR
fi

if [ ! -d $OUT_DIR ]; then
	mkdir $OUT_DIR
fi

if [ ! -d $LOG_DIR ]; then
	mkdir $LOG_DIR
fi

if [ ! -d $CACHE_DIR ]; then
	mkdir $CACHE_DIR
fi

TEST=$2
TEST_LOG_DIR=$LOG_DIR/$TEST

if [ ! -d $TEST_LOG_DIR ]; then
	mkdir $TEST_LOG_DIR
fi

# Run passed command with flags
# ./run_test.sh <path_to_SGN> <test_name>

SCRIPT=$TEST.sh
./$SCRIPT $1 2>&1 | tee $TEST_LOG_DIR/$TEST-$(date +%Y%m%d%H%M).txt
