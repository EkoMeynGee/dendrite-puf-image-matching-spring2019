Rmat = zeros(50,1);
fileName = "b33.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult33.m Rmat