Rmat = zeros(50,1);
fileName = "b32.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult32.m Rmat