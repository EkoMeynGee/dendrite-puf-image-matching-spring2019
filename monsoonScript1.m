%%This is the script to get the matrix for matching 50 * 50results, kind of
%%main function, can only be run in HPC or anykind of high perfermance
%%computing way

Rmat = zeros(50,50);
for index = 1:50
    eval(['fileName = "b' num2str(index) '.tif";']);
    RmatTemp = identification(fileName);
    Rmat(:,index) = RmatTemp;
end

save impuf50x50compareResult.mat Rmat