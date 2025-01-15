ID-TP / ID-TP + (OOD-P - FP)

echo "Getting data for CIFAR-10 benchmark"

echo "downloading CIFAR-10 checkpoint"
python ./scripts/download/download.py \
	--contents 'checkpoints' \
	--datasets 'cifar-10_datasets' \
	--checkpoints 'cifar-10' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'
echo "success!"

echo "downloading CIFAR-10 datasets..."
python ./scripts/download/download.py \
	--contents 'datasets' \
	--datasets 'cifar-10' \
	--checkpoints 'cifar-10' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'
echo "success!"

echo "downloading fractals dataset..."
python ./scripts/download/download.py \
	--contents 'datasets' \
	--datasets 'fractals' \
	--checkpoints 'cifar-10' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'
echo "success!"

echo "starting PixMix checkpoint training"
python main.py \
    --config configs/datasets/cifar10/cifar10.yml \
    configs/networks/resnet18_32x32.yml \
    configs/pipelines/train/baseline.yml \
    configs/preprocessors/pixmix_preprocessor.yml \
    --num_workers 2 \
    --optimizer.num_epochs 100 \
    --mark pixmix \
    --seed 0
echo "success!"

echo "All CIFAR-10 data loaded successfully!"