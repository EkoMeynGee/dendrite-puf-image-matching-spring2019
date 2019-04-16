Rmat = zeros(50,1);
fileName = "b9.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult9.m Rmat