Rmat = zeros(50,1);
fileName = "b35.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult35.m Rmat