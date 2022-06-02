#!/bin/bash
# sh scripts/a_anomaly/2_cutpaste_train_mnist.sh

GPU=1
CPU=1
node=68
jobname=openood

PYTHONPATH='.':$PYTHONPATH \
# srun -p dsta --mpi=pmi2 --gres=gpu:${GPU} -n1 \
# --cpus-per-task=${CPU} --ntasks-per-node=${GPU} \
# --kill-on-bad-exit=1 --job-name=${jobname} -w SG-IDC1-10-51-2-${node} \
python main.py \
--config configs/datasets/digits/mnist.yml \
configs/datasets/digits/mnist_ood.yml \
configs/networks/cutpaste.yml \
configs/pipelines/train/train_cutpaste.yml \
configs/postprocessors/cutpaste.yml \
configs/preprocessors/cutpaste_preprocessor.yml \
--network.name projectionNet \
--trainer.name cutpaste \
--evaluator.name ad \
--optimizer.num_epochs 5 \
--recorder.name ad \
--num_workers 4 \
--network.backbone.name lenet \
--network.backbone.pretrained False