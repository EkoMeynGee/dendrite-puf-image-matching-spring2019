#!/bin/bash
#SBATCH --job-name=readmat
#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results/out47.txt
#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results/error47.txt
#SBATCH --time=5:00:00
#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first
#SBATCH --mem=60000
#SBATCH -c6

module load matlab

matlab -nodisplay -nodesktop -r "run monsoonScript47.m"
srun date