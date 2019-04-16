Rmat = zeros(50,1);
fileName = "b41.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult41.m Rmat