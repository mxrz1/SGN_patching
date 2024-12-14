#!/bin/bash

PWD=$(pwd)
DSET=cifarNls
CP_INTERVAL=100
EPOCHS=600
DATA_DIR=/home/baumana1/work/data/sgn_results/$DSET
OUT_DIR=/home/baumana1/work/data/sgn_results/out/$DSET
CACHE_DIR=/home/baumana1/work/data/sgn_results/.cache/$DSET
SCRIPTS_DIR=$PWD/scripts

# Create necessary directories
mkdir -p $DATA_DIR
mkdir -p $OUT_DIR
mkdir -p $CACHE_DIR
mkdir -p $SCRIPTS_DIR

echo "============== RUNNING $DSET TESTS ================"
echo

submit_job() {
    TEST_NAME=$1
    SCRIPT_NAME="${DSET}_$2"
    DATASET=$3
    CORRUPTION=$4
    shift 4
    JOB_SCRIPT="#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=10:29:00
#SBATCH --account=aalto_users

python src/cifar/deterministic.py --data_dir=$DATA_DIR \
                                  --output_dir=$OUT_DIR/$TEST_NAME \
                                  --dataset $DATASET \
                                  --corruption_type $CORRUPTION \
                                  --train_epochs=$EPOCHS \
                                  --checkpoint_interval=$CP_INTERVAL \
                                  --download_data $@"

    # Save the script in the scripts folder
    SCRIPT_PATH=$SCRIPTS_DIR/$SCRIPT_NAME.sh
    echo "$JOB_SCRIPT" > $SCRIPT_PATH
    chmod +x $SCRIPT_PATH
    sbatch $SCRIPT_PATH
}

echo "============== AGGREGATE ================"
TEST_NAME=aggre
SCRIPT_NAME="aggre"
submit_job $TEST_NAME $SCRIPT_NAME cifar10 aggre --label_smoothing 0.9

echo "============== RANDOM 1 ================"
TEST_NAME=rand1
SCRIPT_NAME="rand1"
submit_job $TEST_NAME $SCRIPT_NAME cifar10 rand1 --label_smoothing 0.5

echo "============== RANDOM 2 ================"
TEST_NAME=rand2
SCRIPT_NAME="rand2"
submit_job $TEST_NAME $SCRIPT_NAME cifar10 rand2 --label_smoothing 0.9

echo "============== RANDOM 3 ================"
TEST_NAME=rand3
SCRIPT_NAME="rand3"
submit_job $TEST_NAME $SCRIPT_NAME cifar10 rand3 --label_smoothing 0.5

echo "============== WORST ================"
TEST_NAME=worst
SCRIPT_NAME="worst"
submit_job $TEST_NAME $SCRIPT_NAME cifar10 worst --label_smoothing 0.7

echo "============== CIFAR-100N ================"
TEST_NAME=cifar100
SCRIPT_NAME="cifar100"
submit_job $TEST_NAME $SCRIPT_NAME cifar100 c100noise --label_smoothing 0.9

echo "All jobs submitted."