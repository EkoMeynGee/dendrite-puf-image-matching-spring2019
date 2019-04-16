Rmat = zeros(50,1);
fileName = "b19.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult19.m Rmat