function quickScripts_sh(start,endplace)

for index = start:endplace
    eval(['edit matching50x50puf' num2str(index) '.sh']);
    eval(['temp = fopen("matching50x50puf' num2str(index) '.sh", "wt");']);
    %%--Writing--
    
    fprintf(temp, '#!/bin/bash\n#SBATCH --job-name=readmat\n#SBATCH --output=/home/zc95/dendrite-puf-monsoon-results/out');
    eval(['fprintf(temp, "' num2str(index) '");']);
    fprintf(temp, '.txt\n');
    fprintf(temp, '#SBATCH --error=/home/zc95/dendrite-puf-monsoon-results/error');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.txt\n');
    fprintf(temp, '#SBATCH --time=5:00:00\n#SBATCH --workdir=/home/zc95/dendrite-puf-image-matching-first\n#SBATCH --mem=60000\n#SBATCH -c6\n\nmodule load matlab\n\n');
    fprintf(temp, 'matlab -nodisplay -nodesktop -r "run monsoonScript');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.m"\n');
    fprintf(temp, 'srun date');

    %---end writing
    fclose(temp);
end