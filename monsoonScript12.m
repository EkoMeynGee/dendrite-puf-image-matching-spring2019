Rmat = zeros(50,1);
fileName = "b12.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult12.m Rmat