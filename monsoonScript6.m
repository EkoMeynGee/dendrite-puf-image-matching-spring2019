Rmat = zeros(50,1);
fileName = "b6.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult6.m Rmat