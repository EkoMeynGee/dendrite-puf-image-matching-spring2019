Rmat = zeros(50,1);
fileName = "b21.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult21.m Rmat