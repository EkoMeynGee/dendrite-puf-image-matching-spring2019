Rmat = zeros(50,1);
fileName = "b7.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult7.m Rmat