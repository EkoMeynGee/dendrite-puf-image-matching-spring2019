function quickScripts(start,endplace)

for index = start:endplace
    eval(['edit noise2Sript' num2str(index) '.m']);
    eval(['temp = fopen("noise2Sript' num2str(index) '.m", "wt");']);
    %%--Writing--
    
    fprintf(temp, 'fileName = \"b');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.tif\"');
    fprintf(temp, ';\nRmatTemp = noiseTestMain(fileName,2);\nsave noiseResult2');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.mat RmatTemp');

    %---end writing
    fclose(temp);
end