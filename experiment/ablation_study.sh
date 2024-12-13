#!/bin/bash

PWD=$(pwd)
DSET=cifar10ablation
CP_INTERVAL=100
EPOCHS=600
DATA_DIR=/home/baumana1/work/data/sgn_results_/$DSET
OUT_DIR=/home/baumana1/work/data/sgn_results_/out/$DSET
CACHE_DIR=/home/baumana1/work/data/sgn_results_/.cache/$DSET
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
    SCRIPT_NAME=$2
    shift 2
    JOB_SCRIPT="#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=10:29:00
#SBATCH --account=aalto_users

python src/cifar/sgn_ablation.py --data_dir=$DATA_DIR \
                        --output_dir=$OUT_DIR/$TEST_NAME \
                        --train_epochs=$EPOCHS \
                        --checkpoint_interval=$CP_INTERVAL \
                        --download_data $@"

    # Save script in the scripts folder
    SCRIPT_PATH=$SCRIPTS_DIR/$SCRIPT_NAME
    echo "$JOB_SCRIPT" > $SCRIPT_PATH
    chmod +x $SCRIPT_PATH
    sbatch $SCRIPT_PATH
}

echo "============== DISABLE LR LC ================="
echo "============== CIFAR10_SYM40_XX ================"
TEST_NAME=CIFAR10_SYM40_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type sym --severity 0.4 --disable_lr --alpha 1

echo "============== CIFAR10_ASYM40_XX ================"
TEST_NAME=CIFAR10_ASYM40_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type asym --severity 0.4 --disable_lr --alpha 1

echo "============== CIFAR10N_RAND1_XX ================"
TEST_NAME=CIFAR10N_RAND1_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type rand1 --disable_lr --alpha 1

echo "============== CIFAR10N_WORST_XX ================"
TEST_NAME=CIFAR10N_WORST_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type worst --disable_lr --alpha 1

echo "============== CIFAR100_SYM40_XX ================"
TEST_NAME=CIFAR100_SYM40_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type sym --severity 0.4 --disable_lr --alpha 1

echo "============== CIFAR100_ASYM40_XX ================"
TEST_NAME=CIFAR100_ASYM40_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type asym --severity 0.4 --disable_lr --alpha 1

echo "============== CIFAR100N_XX ================"
TEST_NAME=CIFAR100N_XX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type c100noise --disable_lr --alpha 1


echo "============== LX ================="
echo "============== CIFAR10_SYM40_LX ================"
TEST_NAME=CIFAR10_SYM40_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type sym --severity 0.4 --alpha 1

echo "============== CIFAR10_ASYM40_LX ================"
TEST_NAME=CIFAR10_ASYM40_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type asym --severity 0.4 --alpha 1

echo "============== CIFAR10N_RAND1_LX ================"
TEST_NAME=CIFAR10N_RAND1_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type rand1 --alpha 1

echo "============== CIFAR10N_WORST_LX ================"
TEST_NAME=CIFAR10N_WORST_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type worst --alpha 1

echo "============== CIFAR100_SYM40_LX ================"
TEST_NAME=CIFAR100_SYM40_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type sym --severity 0.4 --alpha 1

echo "============== CIFAR100_ASYM40_LX ================"
TEST_NAME=CIFAR100_ASYM40_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type asym --severity 0.4 --alpha 1

echo "============== CIFAR100N_LX ================"
TEST_NAME=CIFAR100N_LX
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type c100noise --alpha 1

#echo "============== LL ================="
#echo "get data from other runs"

echo "============== XL ================="
echo "============== CIFAR10_SYM40_XL ================"
TEST_NAME=CIFAR10_SYM40_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type sym --severity 0.4 --disable_lr --alpha 0.991

echo "============== CIFAR10_ASYM40_XL ================"
TEST_NAME=CIFAR10_ASYM40_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type asym --severity 0.4 --disable_lr --alpha 0.997

echo "============== CIFAR10N_RAND1_XL ================"
TEST_NAME=CIFAR10N_RAND1_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type rand1 --disable_lr --alpha 0.995

echo "============== CIFAR10N_WORST_XL ================"
TEST_NAME=CIFAR10N_WORST_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar10 --noisy_labels --corruption_type worst --disable_lr --alpha 0.993

echo "============== CIFAR100_SYM40_XL ================"
TEST_NAME=CIFAR100_SYM40_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type sym --severity 0.4 --disable_lr --alpha 0.995

echo "============== CIFAR100_ASYM40_XL ================"
TEST_NAME=CIFAR100_ASYM40_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type asym --severity 0.4 --disable_lr --alpha 0.997

echo "============== CIFAR100N_XL ================"
TEST_NAME=CIFAR100N_XL
SCRIPT_NAME="$TEST_NAME.sh"
submit_job $TEST_NAME $SCRIPT_NAME --dataset cifar100 --noisy_labels --corruption_type c100noise --disable_lr --alpha 0.993


echo "All jobs submitted."