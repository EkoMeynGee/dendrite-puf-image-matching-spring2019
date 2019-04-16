Rmat = zeros(50,1);
fileName = "b34.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult34.m Rmat