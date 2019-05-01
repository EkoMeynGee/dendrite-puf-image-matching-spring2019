#!/bin/bash
#SBATCH --job-name=readmat
#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results/out16.txt
#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results/error16.txt
#SBATCH --time=100:00:00
#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first
#SBATCH --mem=60000
#SBATCH -c6

module load matlab

matlab -nodisplay -nodesktop -r "run noise2Sript16.m"
srun date