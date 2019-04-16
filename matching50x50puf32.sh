#!/bin/bash
#SBATCH --job-name=readmat
#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results/out32.txt
#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results/error32.txt
#SBATCH --time=5:00:00
#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first
#SBATCH --mem=60000
#SBATCH -c6

module load matlab

matlab -nodisplay -nodesktop -r "run monsoonScript32.m"
srun date