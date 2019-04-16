Rmat = zeros(50,1);
fileName = "b3.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult3.m Rmat