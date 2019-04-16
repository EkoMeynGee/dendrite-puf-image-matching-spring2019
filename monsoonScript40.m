Rmat = zeros(50,1);
fileName = "b40.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult40.m Rmat