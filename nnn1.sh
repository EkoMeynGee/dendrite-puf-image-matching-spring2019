#!/bin/bash
#SBATCH --job-name=readmat
#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results2/out1.txt
#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results2/error1.txt
#SBATCH --time=24:00:00
#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first2
#SBATCH --mem=60000
#SBATCH -c6

module load matlab

matlab -nodisplay -nodesktop -r "run noiseSript1.m"
srun date