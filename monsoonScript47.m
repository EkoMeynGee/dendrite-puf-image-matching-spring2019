Rmat = zeros(50,1);
fileName = "b47.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult47.m Rmat