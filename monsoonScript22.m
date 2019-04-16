Rmat = zeros(50,1);
fileName = "b22.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult22.m Rmat