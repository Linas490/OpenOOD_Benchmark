#!/bin/bash

echo "Starting the download process"

echo "Download CIFAR-10 checkpoint"
#Get CIFAR-10 checkpoint
python ./scripts/download/download.py \
	--contents 'checkpoints' \
	--checkpoints 'cifar-10' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'

echo "Download CIFAR-10 checkpoint"
#Get CIFAR-10 benchmark datasets
python ./scripts/download/download.py \
	--contents 'datasets' \
	--datasets 'cifar-10_datasets' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'

echo "Download Fractals dataset"
#Get Fractals dataset for PixMix
python ./scripts/download/download.py \
	--contents 'datasets' \
	--datasets 'fractals' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'

echo "Train CIFAR-10 on Fractals"
#Get Resnet_18 CIFAR-10 + Fractals checkpoint for PixMix
python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/train/baseline.yml \
    configs/preprocessors/pixmix_preprocessor.yml \
    --num_workers 8 \
    --optimizer.num_epochs 100 \
    --mark pixmix \
    --seed 0

  echo "Process complete"