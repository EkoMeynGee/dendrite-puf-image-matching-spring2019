Rmat = zeros(50,1);
fileName = "b39.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult39.m Rmat