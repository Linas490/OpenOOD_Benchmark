#!/bin/bash

# Loop for 10 repetitions
for i in {1..10}
do
  echo "Iteration $i"

  # MSP Evaluation
  echo "Running MSP Evaluation"
  if ! python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/datasets/cifar10/cifar10_ood.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/test/test_ood.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/postprocessors/msp.yml \
    --num_workers 2 \
    --network.checkpoint './results/cifar10_resnet18_32x32_base_e100_lr0.1_default/s0/best.ckpt' \
    --mark $i \
    --merge_option merge; then
    echo "Error during MSP evaluation at iteration $i"
    exit 1
  fi

  # MDS Evaluation
  echo "Running MDS Evaluation"
  if ! python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/datasets/cifar10/cifar10_ood.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/test/test_ood.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/postprocessors/mds.yml \
    --num_workers 2 \
    --network.checkpoint 'results/cifar10_resnet18_32x32_base_e100_lr0.1_default/s0/best.ckpt' \
    --mark $i; then
    echo "Error during MDS evaluation at iteration $i"
    exit 1
  fi

  # ODIN Evaluation
  echo "Running ODIN Evaluation"
  python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/datasets/cifar10/cifar10_ood.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/test/test_ood.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/postprocessors/odin.yml \
    --num_workers 2 \
    --network.checkpoint 'results/cifar10_resnet18_32x32_base_e100_lr0.1_default/s0/best.ckpt' \
    --mark $i; then
    echo "Error during ODIN evaluation at iteration $i"
    exit 1
  fi
  
  # DICE Evaluation
  echo "Running DICE Evaluation"
  python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/datasets/cifar10/cifar10_ood.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/test/test_ood.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/postprocessors/dice.yml \
    --num_workers 2 \
    --network.checkpoint './results/cifar10_resnet18_32x32_base_e100_lr0.1_default/s0/best.ckpt' \
    --mark $i; then
    echo "Error during DICE evaluation at iteration $i"
    exit 1
  fi

  # PixMix Evaluation
  echo "Running Pixmix Evaluation"
  python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/datasets/cifar10/cifar10_ood.yml \
    configs/networks/resnet18_32x32.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/pipelines/test/test_ood.yml \
    configs/preprocessors/base_preprocessor.yml \
    configs/postprocessors/msp.yml \
    --num_workers 2 \
    --network.checkpoint 'results/cifar10_resnet18_32x32_base_e100_lr0.1_pixmix/s0/best.ckpt' \
    --mark pixmix_$i; then
    echo "Error during PixMix evaluation at iteration $i"
    exit 1
  fi
  
done

echo "All evaluations completed 10 times."
