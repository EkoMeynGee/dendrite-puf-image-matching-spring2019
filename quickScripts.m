function quickScripts(start,endplace)

for index = start:endplace
    eval(['edit noiseSript' num2str(index) '.m']);
    eval(['temp = fopen("noiseSript' num2str(index) '.m", "wt");']);
    %%--Writing--
    
    fprintf(temp, 'fileName = \"b');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.tif\"');
    fprintf(temp, ';\nRmatTemp = noiseTestMain(fileName,2);\nsave noiseResult');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.mat RmatTemp');

    %---end writing
    fclose(temp);
end