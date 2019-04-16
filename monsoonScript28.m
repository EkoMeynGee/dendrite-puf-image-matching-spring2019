Rmat = zeros(50,1);
fileName = "b28.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult28.m Rmat