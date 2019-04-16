Rmat = zeros(50,1);
fileName = "b14.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult14.m Rmat