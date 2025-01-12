# sh ./scripts/download/dowanload.sh

# download the up-to-date benchmarks and checkpoints
# provided by OpenOOD v1.5
python ./scripts/download/download.py \
	--contents 'datasets' 'checkpoints' \
	--datasets 'cifar-10_datasets' \
	--checkpoints 'cifar-10' \
	--save_dir './data' './results' \
	--dataset_mode 'benchmark'
