Rmat = zeros(50,1);
fileName = "b26.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult26.m Rmat