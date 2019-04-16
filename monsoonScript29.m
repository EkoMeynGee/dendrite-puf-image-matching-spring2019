Rmat = zeros(50,1);
fileName = "b29.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult29.m Rmat