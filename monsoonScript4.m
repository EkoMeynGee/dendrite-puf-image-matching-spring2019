Rmat = zeros(50,1);
fileName = "b4.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult4.m Rmat