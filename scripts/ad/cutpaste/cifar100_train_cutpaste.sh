#!/bin/bash
# sh scripts/ad/cutpaste/cifar100_train_cutpaste.sh

GPU=1
CPU=1
node=68
jobname=openood

PYTHONPATH='.':$PYTHONPATH \
# srun -p dsta --mpi=pmi2 --gres=gpu:${GPU} -n1 \
# --cpus-per-task=${CPU} --ntasks-per-node=${GPU} \
# --kill-on-bad-exit=1 --job-name=${jobname} -w SG-IDC1-10-51-2-${node} \
python main.py \
--config configs/datasets/cifar100/cifar100.yml \
configs/datasets/cifar100/cifar100_ood.yml \
configs/networks/cutpaste.yml \
configs/pipelines/train/train_cutpaste.yml \
configs/preprocessors/cutpaste_preprocessor.yml \
configs/postprocessors/cutpaste.yml \
--network.pretrained False \
--network.backbone.name resnet18_32x32 \
--network.backbone.pretrained True \
--network.backbone.checkpoint 'results/cifar100_resnet18_32x32_base_e100_lr0.1/best.ckpt' \
--num_workers 8 \
--optimizer.num_epochs 100 \
--force_merge True