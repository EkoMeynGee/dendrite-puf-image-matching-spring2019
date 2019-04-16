%%This is the script to get the matrix for matching 50 * 50results, kind of
%%main function, can only be run in HPC or anykind of high perfermance
%%computing way

Rmat = zeros(50,1);
fileName = "b2.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;

save impuf50x50compareResult2.mat Rmat