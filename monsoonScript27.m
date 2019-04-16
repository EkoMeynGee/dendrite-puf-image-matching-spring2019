Rmat = zeros(50,1);
fileName = "b27.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult27.m Rmat