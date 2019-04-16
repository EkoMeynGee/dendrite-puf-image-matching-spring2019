Rmat = zeros(50,1);
fileName = "b36.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult36.m Rmat