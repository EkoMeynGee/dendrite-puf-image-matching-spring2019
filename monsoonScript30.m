Rmat = zeros(50,1);
fileName = "b30.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult30.m Rmat