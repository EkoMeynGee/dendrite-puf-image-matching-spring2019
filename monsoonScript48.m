Rmat = zeros(50,1);
fileName = "b48.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult48.m Rmat