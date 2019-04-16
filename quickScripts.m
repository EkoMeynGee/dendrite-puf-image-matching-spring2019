function quickScripts(start,endplace)

for index = start:endplace
    eval(['edit monsoonScript' num2str(index) '.m']);
    eval(['temp = fopen("monsoonScript' num2str(index) '.m", "wt");']);
    %%--Writing--
    
    fprintf(temp, 'Rmat = zeros(50,1);\n');
    fprintf(temp, 'fileName = \"b');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.tif\"');
    fprintf(temp, ';\nRmatTemp = identification(fileName);\nRmat(:) = RmatTemp;\nsave impuf50x50compareResult');
    eval(['fprintf(temp, "' num2str(index) '");'])
    fprintf(temp, '.m Rmat');
    
    
    %---end writing
    fclose(temp);
end