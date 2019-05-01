#!/bin/bash
#SBATCH --job-name=readmat
#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results/out19.txt
#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results/error19.txt
#SBATCH --time=100:00:00
#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first
#SBATCH --mem=60000
#SBATCH -c6

module load matlab

matlab -nodisplay -nodesktop -r "run noise2Sript19.m"
srun date