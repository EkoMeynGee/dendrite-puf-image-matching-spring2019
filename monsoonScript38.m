Rmat = zeros(50,1);
fileName = "b38.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult38.m Rmat